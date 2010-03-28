Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 590EDB7C98
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 02:48:52 +1100 (EST)
Date: Sun, 28 Mar 2010 17:48:46 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: question about drivers/macintosh/windfarm_pm91.c
Message-ID: <Pine.LNX.4.64.1003281746570.29824@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function wf_smu_remove in the file drivers/macintosh/windfarm_pm91.c 
ends with the following code:

        if (wf_smu_slots_fans)
                kfree(wf_smu_cpu_fans);
	if (wf_smu_drive_fans)
                kfree(wf_smu_cpu_fans);
        if (wf_smu_cpu_fans)
                kfree(wf_smu_cpu_fans);

This looks quite strange.  Is it supposed to be if (x) kfree(x); in each 
case?

julia
