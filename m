Return-Path: <diggskevin38@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) by ozlabs.org (Postfix) with ESMTP id 9A652B70CC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 06:40:36 +1100 (EST)
Received: by eyg24 with SMTP id 24so1482181eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 28 Oct 2010 12:40:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinaYPUwX+YOJh1pCKmSWS_JmG8+eHQ3QvJgG3KA@mail.gmail.com>
References: <AANLkTinaYPUwX+YOJh1pCKmSWS_JmG8+eHQ3QvJgG3KA@mail.gmail.com>
Date: Thu, 28 Oct 2010 14:40:32 -0500
Message-ID: <AANLkTinggQU_4Oo0VkiK3u1bZ9Sg1As59PXEDMFDOQoJ@mail.gmail.com>
Subject: Re: PowerMac G5 config
From: kevin diggs <diggskevin38@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Apparently, for some reason, you can't use -depth in your  find
command when rebuilding your initrd???

Machine is now running 2.6.36. Glad to be rid of that awful cpufreq driver ...

kevin

On Mon, Oct 25, 2010 at 1:45 PM, kevin diggs <diggskevin38@gmail.com> wrote:
> Hi,
>
> I have a G5 (dual 970FX, june 2004?) running YDL 6.0. After fighting
> to get a compiler that will build 2.6.29+ (4.2.1 -> 4.2.2) I can't get
> it to boot. It spits out a bunch of message about devices (I think the
> last ones are USB related) and then says:
>
> Restarting System
>
> and then reboots. I've attached a diff of the 2.6.28 config that will boot.
>
> Any suggestions would be greatly appreciated. Thanks!
>
> kevin
>
