To: "=?iso-8859-1?Q?J=F3n_Benediktsson?=" <jonb@marel.is>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE on Lite5200 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 03 Mar 2004 17:55:15 GMT."
             <OF12C112DE.67675BE6-ON00256E4C.0060B975-00256E4C.0062715E@marel.is>
Date: Wed, 03 Mar 2004 19:47:08 +0100
Message-Id: <20040303184713.3056EC1183@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <OF12C112DE.67675BE6-ON00256E4C.0060B975-00256E4C.0062715E@marel.is> you wrote:
>
> I am working with a Lite5200 board.  I have u-boot running in a LOWBOOT
> configuration and I can run the Denx linux kernel for MPC5200,
>  using an nfs root filesystem.
>
> Now I want to add IDE support to the kernel.  I already have IDE support in
> u-boot and my disk is detected in the startup.
> I have added what I can think of to the kernel config but I am stuck with a
> linking error when running 'make uImage'.
> Following is the last output of the make, indicating the error.

This was a typo in the Makefile. Please update the sources  from  our
CVS server, and it should work:

---------------------
PatchSet 184
Date: 2004/02/26 15:58:47
...
Fix typo which prevented IDE from working on MPC5200

Members:
...
        drivers/ide/ppc/Makefile:1.4->1.5
...
---------------------


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In Nature there are neither rewards nor punishments, there are conse-
quences.                                            -- R.G. Ingersoll

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
