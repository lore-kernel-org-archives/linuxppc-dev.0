To: digitalRNA <horizonprits@yahoo.co.jp>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: u-boot-0.3.0 + Linux boot failed on walnut 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 22 May 2003 02:15:39 +0900."
             <3ECBB43B.2000601@yahoo.co.jp>
Date: Wed, 21 May 2003 21:46:31 +0200
Message-Id: <20030521194636.F2C42C6162@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3ECBB43B.2000601@yahoo.co.jp> you wrote:
>
> Now I am trying to boot Linux using u-boot-0.3.0 not openbios on walnut.
> But it failed.

Did you read the documentation, and have a look at the  mailing  list
archives?

> It looks failed around timer initialization on vmlinux.
> But in the case of openbios, the Linux can boot.
> Are there any information about this issue?

Sure. Of course it's  difficult  to  guess  what's  wrong  with  your
configuration, but there are several typical sources of error:

- missing / wrong adaption of the bd_info structure
- bad passing pf clock information (see discusssion of clocks_in_mhz
  environment variable)


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Above all else -- sky.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
