Return-Path: <jaillon@emse.fr>
Message-ID: <41A62853.8060107@emse.fr>
Date: Thu, 25 Nov 2004 19:45:39 +0100
From: Philippe Jaillon <jaillon@emse.fr>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: pb booting 2.6.9 kernel on Tibook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I have problem configuring a booting 2.6 kernel. it hang at
"adb: starting probe task"

My last experiment are for a 2.6.9 kernel were sources come from
source.mvista.com bitkeper linuxppc-2.5 tree. I clone the sources
tagged v2.6.9_linuxppc. I use the pmac default config. Build works
fine, i have a kernel, some modules... I install all the stuff,
update my yaboot.conf, run ybin and reboot.

Some body known where i am wrong ?

My latop is
processor       : 0
cpu             : 7450, altivec supported
clock           : 667MHz
revision        : 2.1 (pvr 8000 0201)
bogomips        : 665.19
machine         : PowerBook3,3
motherboard     : PowerBook3,3 MacRISC2 MacRISC Power Macintosh
board revision  : 00000001
detected as     : 72 (PowerBook Titanium II)
pmac flags      : 0000000b
L2 cache        : 256K unified
memory          : 512MB
pmac-generation : NewWorld

Regards and thank you for your help
-- 
Philippe JAILLON              Ecole des Mines de St-Etienne
158, Cours Fauriel            Tel.  (+33) 04 77 42 66 04
42023 Saint-Etienne, FRANCE   Fax   (+33) 04 77 42 66 66
