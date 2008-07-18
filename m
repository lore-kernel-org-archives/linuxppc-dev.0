Return-Path: <neko@genesi-usa.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 27262DE049
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 22:14:30 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so49144ugf.0
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 05:14:24 -0700 (PDT)
Message-ID: <48808914.20702@genesi-usa.com>
Date: Fri, 18 Jul 2008 13:14:12 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: 2.6.26 does not boot on Pegasos
References: <20080715100033.GA5147@iram.es> <487CC1F5.5090706@genesi-usa.com>
	<20080715155944.GA11881@iram.es>
In-Reply-To: <20080715155944.GA11881@iram.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Gabriel Paubert wrote:
> On Tue, Jul 15, 2008 at 04:27:49PM +0100, Matt Sealey wrote:
>> If you built this kernel yourself, you need to do it from a system with
>> an up-to-date binutils (2.18) otherwise, it does this.

Note to the linux-ppc guys; is there any changelog entry which reports
this requirement somewhere? I didn't find one...

> Thanks, this is likely the problem. The distribution is Debian stable 
> with all security udates but the binutils are still 2.17.

That's generally the problem we had with SuSE 10.3. Debian stable
should be updated by Christmas.. :D

> Trying to add Lenny source does not help, bummer. Aptitude fails 
> with an error message like "Dynamic MMap ran out of room".

Ouch. Well, all I can recommend is grabbing the source files from;

http://packages.debian.org/source/testing/binutils

And compiling and installing it manually. There is a bit of a
disparity between glibc support between testing and stable that
the prebuild packages will complain about (you have to install
half of Lenny to do it, which is a bad idea just to update one
package).

Once you have the files you can just use "dpkg -x binutils-blah.dsc"
to get going.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
