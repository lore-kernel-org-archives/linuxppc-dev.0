Return-Path: <robin@india.tejasnetworks.com>
Received: from pop-mail.india.tejasnetworks.com (india.tejasnetworks.com
	[164.164.94.83]) by ozlabs.org (Postfix) with SMTP id A465D2BF07
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jan 2005 21:04:07 +1100 (EST)
Message-ID: <4229EDFB.2040402@india.tejasnetworks.com>
From: Robin <robin@india.tejasnetworks.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org,
	Linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: TZ variable setting for denx 2.4.20
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>
Date: Thu, 06 Jan 2005 10:04:09 -0000

Hi all,
I am trying to find a way of setting TZ environment variable with DST
support for southern hemisphere countries. Its giving a strange problem.
In southern hemisphere countries, DST starts around Oct and ends around
March. The DST time seems to be applicable from Oct until Dec31,19:00hrs.
Then it reverts back to standard time.

For northern hemisphere countries, its working perfectly.(Here DST starts
around March and ends around Oct. There is no year crossing DST period.)

I am sending the system timezone at various times..

bash> export TZ="xxx5:30yyy4:30,M10.1.1,M2.1.1"
bash> date 10010159
Mon Oct  1 01:59:00 xxx 2001
bash> date
Mon Oct  1 01:59:47 xxx 2001
bash> date
Mon Oct  1 03:00:10 yyy 2001
bash> date 12311900
Mon Dec 31 19:00:00 yyy 2001
bash> date 12311959
Mon Dec 31 18:59:00 xxx 2001 <----------- problem. It should have
reverted to xxx only in feb.

Please give me some idea for setting time zone for southern hemisphere
countries.

I am using 2.4.20 linux kernel from denx.I am running date command from
busybox version 0.6 which in is using strftime. The processor is ppc860T.

Regards,
Robin Mathew
