To: None Atall <linux_meis@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Early malloc function (MPC826x) ?? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 May 2003 00:18:39 PDT."
             <20030520071839.36639.qmail@web9708.mail.yahoo.com>
Date: Tue, 20 May 2003 09:48:56 +0200
Message-Id: <20030520074901.2AFD6C6162@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Dimitris,

in message <20030520071839.36639.qmail@web9708.mail.yahoo.com> you wrote:
>
> Is there a function that I can call (for memory
> allocation (just like kmalloc)) but in the early init
> stage inside "m8260_cpm_dpalloc" or "m8260_cpm_reset"?
>  I want to implement "m8260_cpm_dpalloc" with linked
> lists, so that I can implement "m8260_cpm_dpfree" as
> well. But of course, with kmalloc( ,GFP_KERNEL), the
> system will not boot :))

Why do you want to re-invent the wheel?

This has been done before. Several times already.

See for example the DPRAM list allocator for the 8xx in our linux-2.4
kernel tree,  or  the  patches  submitted  by  Pantelis  Antoniou  in
December last year.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The light at the end of the tunnel is usually a "No Exit" sign.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
