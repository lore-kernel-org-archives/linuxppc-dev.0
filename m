To: Dave Lawrence <dgl@integrinautics.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC5200LITE U-boot/Linux howto 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 10 Nov 2003 07:43:14 PST."
             <3FAFB212.CFB06600@integrinautics.com>
Date: Mon, 10 Nov 2003 17:12:45 +0100
Message-Id: <20031110161250.981BAC5F59@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Dave,

in message <3FAFB212.CFB06600@integrinautics.com> you wrote:
>
...
> The linuxppc_2_4_mpc5200 kernel source directory from CVS

Just a minor correction: the linuxppc_2_4_mpc5200 module on  our  CVS
server is obsolete. We just keep it because of the change logs.

Please use the linuxppc_2_4_devel tree instead.  All  MGT5100/MPC5200
relevant stuff has been merged, and actually new stuff has been added
since.

> #Linux
> cvs -d :pserver:anonymous@www.denx.de:/cvsroot login
> (no password)
> cvs -z6 -d :pserver:anonymous@www.denx.de:/cvsroot co -P
> linuxppc_2_4_mpc5200

Please use instead:

	cvs -d :pserver:anonymous@www.denx.de:/cvsroot login
	cvs -z6 -d :pserver:anonymous@www.denx.de:/cvsroot co -P linuxppc_2_4_devel


> #here endeth the lesson

Thanks a lot!

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A person with one watch knows what time it  is;  a  person  with  two
watches is never sure.                                       Proverb

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
