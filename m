Return-Path: <frank.svendsboe@gmail.com>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 2C5A9B7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 23:06:48 +1000 (EST)
Received: by ewy21 with SMTP id 21so989545ewy.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 06:06:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d15e5cf90909110459p221d4bc3nc9e1d45b95bce6bd@mail.gmail.com>
References: <d15e5cf90909110459p221d4bc3nc9e1d45b95bce6bd@mail.gmail.com>
Date: Fri, 11 Sep 2009 15:06:44 +0200
Message-ID: <1ba63b520909110606x4599dd5bt428e03775805dff2@mail.gmail.com>
Subject: Re: linux booting fine but running slow
From: =?ISO-8859-1?Q?Frank_Svendsb=F8e?= <frank.svendsboe@gmail.com>
To: "Gao Ya'nan" <abutter.gao@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, stevan@iritel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Gao and Stevan

I've observed the same slow-down issue on an MPC875 a while now, but
haven't had the time to do a git-bisect
and find the patch that causes the problem. So far, I'm running
torvalds 2.6.29-rc6, and the slow-down problem
was introduced somewhere between 2.6.26-rc6 and 2.6.30-rc2.

What options did you specify to improve the performance?

Regards,
Frank

On Fri, Sep 11, 2009 at 1:59 PM, Gao Ya'nan <abutter.gao@gmail.com> wrote:
> Hi, stevan, I had met a similarly problem with U-Boot-v2009.08 and
> DENX-v2.6.30.3 Linux.
>
> Today, I add some options to Linux, everythings worked well, but I got
> a fat kernel. Do you solve it now ?
>
> Gao Ya'nan
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
