To: bart@ardistech.com
Cc: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ppcboot on 823e RPXlite config? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 26 Apr 2002 14:05:45 +0200."
             <3CC94299.184463A5@ardistech.com>
Date: Fri, 26 Apr 2002 15:56:52 +0200
Message-Id: <20020426135657.D9111FF65@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3CC94299.184463A5@ardistech.com> you wrote:
>
> Does anybody on the list has the configuration files for ppcboot on a

You would get _much_ better response  on  the  ppcboot-users  mailing
list.

> RPX lite board with an MPC823e processor? In ppcboot 1.1.5 this board
> is set to a MPC850 cpu, but the one I have over here is a MPC823e one.

Software-wise there is little difference between a  850  and  a  823,
except  for  the  obvious  details like the fact that there is no LCD
controller on the 850.

I don't know the RPXlite, but on TQM8xxL tha image  for  the  TQM850L
will  also  provide  basic  functionality  on  a TQM823L (missing LCD
output, of course).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A list is only as strong as its weakest link.            -- Don Knuth

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
