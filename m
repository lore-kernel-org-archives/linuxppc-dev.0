Return-Path: <francois.barre@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.187])
	by ozlabs.org (Postfix) with ESMTP id A18F4679FB
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Aug 2006 19:53:26 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id p48so1399001nfa
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Aug 2006 02:53:24 -0700 (PDT)
Message-ID: <fd8d0180608040253h11ebf168p8656b370857f1647@mail.gmail.com>
Date: Fri, 4 Aug 2006 11:53:24 +0200
From: "Francois Barre" <francois.barre@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: AOA and Toonie (Mac Mini) : nothing happens
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I am now trying the AOA driver on a Mac Mini 1.2Ghz, using 2.6.18-rc3
linux/kernel/git/linville/wireless-dev.git kernel.
At startup, no module is loaded. When I try to manually modprobe
snd-aoa-*.ko and snd-aoa-codec-toonie.ko, no error is shown in dmesg,
but no device is binded to modules. Finally, nothing happens.

I know I shall provide more data but I lost connection to the machine right now.

Did I miss something ?
What is the process for loading modules in AOA ?
Do I have to alter my alsa config files ?

Regards,
