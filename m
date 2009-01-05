Return-Path: <neko@genesi-usa.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 8B081DDFF9
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jan 2009 11:07:09 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so2125764yxg.39
	for <linuxppc-dev@ozlabs.org>; Sun, 04 Jan 2009 16:07:08 -0800 (PST)
Sender: Matt Sealey <neko@genesi-usa.com>
Message-ID: <49614F36.2040406@genesi-usa.com>
Date: Sun, 04 Jan 2009 18:07:18 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: cpu_die on MPC8641D
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I just built a kernel with a config very similar to the MPC8641HPCN 
defconfig and for some reason at the end of the build I got an error 
saying there was no symbol "cpu_die".

I can't work out what I missed here, I checked a few LXRs to 
cross-reference where the symbol might come from and there are things 
for 64-bit CPUs (kernel/setup_64.c) and for PowerMacs but there seems to 
be no "generic" SMP support for 32-bit/e600 cores at all?

I'm trying not to have any Mac drivers in the kernel, but it seems I 
need to make sure I build in the generic PowerMac platform support to 
get SMP? Why?

-- Matt Sealey <matt@genesi-usa.com>
