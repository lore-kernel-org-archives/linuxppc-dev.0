Return-Path: <adams.ppc@gmail.com>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.233])
	by ozlabs.org (Postfix) with ESMTP id D4E86DDECA
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Aug 2008 00:19:24 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d11so1324749qbd.39
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 09 Aug 2008 07:19:23 -0700 (PDT)
Message-ID: <4a21eaea0808090719s58ce1e98q96192432d3951409@mail.gmail.com>
Date: Sat, 9 Aug 2008 08:19:22 -0600
From: "bhanu jampala" <adams.ppc@gmail.com>
To: "M. Warner Losh" <imp@bsdimp.com>
Subject: Re: 8270 MCC driver development
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Warner,

Sorry, I was asking about MCC not MMC. It is my mistake.

I am looking for a MCC(multi channel controller) driver to interface
the 128 channels using TSA to interface with T1 signals coming form
CO. I am right now figuring out and validating few drivers from which
I would be choosing one to work on and modify it as per needs.

Any pointers on MCC support code on Linux or in general would be helpful.

I have a custom board selected. I am looking to support the MCC along
with TSA under Linux.

Regards,
Adams


On Fri, Aug 8, 2008 at 10:57 AM, M. Warner Losh <imp@bsdimp.com> wrote:
> In message: <4a21eaea0808080920j5a3d4115t3085dc18fadc1457@mail.gmail.com>
>            "bhanu jampala" <adams.ppc@gmail.com> writes:
> : I am working on an embedded 8270 based project requiring MCC support.
> : The idea behind is to submit a acceptable MMC driver to the Linux community.
> : I would like to know if there are some existing drivers for MMC in
> : Linux which I can use.
>
> Are you asking about the base support for the mmc protocol in linux?
> Or for the drivers for the 82xx parts?
>
> Warner
>
