Message-Id: <37023590.741A85E6@pop.agri.ch>
Date: Wed, 31 Mar 1999 16:47:44 +0100
From: Andreas Tobler <toa@pop.agri.ch>
Mime-Version: 1.0
To: "Shuangjun Zhu (r44089)" <r44089@email.sps.mot.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Help about Reboot
References: <004301be7b50$e165d520$66f102de@sjzhu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




Shuangjun Zhu wrote:
> 
> Hello, everyone
>   I build the kernel version 2.2.2 on my PowerStack machine.
> But when I execute the command "reboot", the system seems
> to hang up after it print the message "Restarting system.",
> it has not RESTART. If I use the kernel verion 2.1.57,
> everything is OK. Does anyone know about it?
> Any suggestion is appreciated !
> Thanks in advanced!

what about 'shutdown -r now' ?

Andreas
-- 
| Andreas Tobler				
| CH-8004 Zuerich 							
| E-Mail: andreas.tobler@alcatel.ch	| a.tobler@schweiz.ch
-----------------------------------------------------------

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
