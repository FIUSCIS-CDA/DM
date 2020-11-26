#### MODULE NAME
       DM

#### DEPENDENCIES
       None

#### INPUTS
Name | Size(Bits)
------|-------------
a   |     32     
wd  |     32     
we  |     1      

#### OUTPUTS
Name | Size(Bits)
------|-------------
rd  |     32     

#### DESCRIPTION
       Random  access  data  memory. rd = contents os address a.  Value at ad-
       dress a is set to wd if we is equal to 1.

#### AUTHOR
       Alexander T Pastoriza

#### SEE ALSO
       qms(1), modclone(1)
