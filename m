Message-Id: <199905240851.KAA03667@wanadoo.fr>
Date: Mon, 24 May 1999 10:52:04 +0200
From: Lucas Vergnettes <lucas@promac.org>
Subject: bttv working for PPC!
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org,
        linux-pmac@samba.anu.edu.au
MIME-Version: 1.0
Content-Type: text/plain; Charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi to all!

bttv, the driver for Bt848 based TV Cards is now working on linux/ppc!

For the version 0.6.4, just apply this to driver/bttv.c

 3997c3997
<   unsigned char command;
---
>   unsigned char command; 
3999c3999,4000
< 
---
>        u_int32_t cmd;
>        

The problem, now, is that I can't manage to compile and use a tv visualisation
application...
If anyone has clues about this, please help!

Thanks 
Lucas

-- 
Lucas Vergnettes  -- Osteopathy Student --  mailto:lucas@promac.org
LinuxPPC, Ostéopathie et astuces telnet sur http://lucas.promac.org
EMACS : Escape-Meta-Alt-Control-Shift



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
