Message-ID: <3ECA540C.2030506@mvista.com>
Date: Tue, 20 May 2003 11:13:00 -0500
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: XOL <xol@mail.ru>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: perl under eldk for ppc8xx
References: <E19I9dj-0002cW-00.xol-mail-ru@f21.mail.ru>
In-Reply-To: <E19I9dj-0002cW-00.xol-mail-ru@f21.mail.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If you are going to be building perl, you really need to do it "self-hosted",
unless you are prepared to do significant modification to the perl build system.
  Perl insists on being self-hosted compiled, it generates dynamic signal lists
and other structures based on the machine performing the compile, obviously that
doesn't work right in a cross compile situation.

--Mark

XOL wrote:
> Hello.
> I found out that eldk 2.1.0 whic I'm using has no perl.
> Does anybody succeded to build perl for ppc8xx?
> Can you give please some details. Probably you have binaries/rpm
> Thank you. Xol.
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
