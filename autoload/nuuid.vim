
" Use python to generate a new UUID
function! nuuid#NuuidNewUuid()
python << endpy
import vim
from uuid import uuid4
vim.command("let l:new_uuid = '%s'"% str(uuid4()))
endpy
	return l:new_uuid
endfunction

