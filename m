Return-Path: <rajanibabu@embeyond.com>
Received: from mailstorage.nshosts.com (mailstorage.nshosts.com [69.80.208.31])
	by ozlabs.org (Postfix) with ESMTP id 05E3367A3D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 18:03:02 +1000 (EST)
Received: from embeyond.com (unverified [69.80.208.20]) by
	mailstorage.nshosts.com (Vircom SMTPRS 5.3.232) with ESMTP id
	<B0101427573@mailstorage.nshosts.com> for
	<linuxppc-embedded@ozlabs.org>; Wed, 21 Jun 2006 01:29:24 -0600
Message-ID: <a2989a1080004219829d152dd5693be1.rajanibabu@embeyond.com>
From: "Rajanibabu" <rajanibabu@embeyond.com>
To: linuxppc-embedded@ozlabs.org
Subject: porting Linux 2.4 on ML403
Date: Wed, 21 Jun 2006 01:33:06 -0600
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi JF Hasson
   I am trying to port linux 2=2E4 devel to ML403=2E iam using the links htt=
p://splish=2Eee=2Ebyu=2Eedu/projects/LinuxFPGA/configuring=2Ehtm and http://=
www=2Eklingauf=2Ede/v2p/index=2Ephtml=2E Using these links i have done the f=
ollowing tasks=2E
 1=2E Build the kernel and created the system=2Eace file
 2=2E created 3 partitions in 512Mb Compact flash ie A=2Efat-16 (60Mb)
                                                   B=2ELinux-swap (50Mb)
                                                   C=2Eext3 (remaining 380Mb)=

 3=2E copy system=2Eace to first partition i=2Ee fat-16=2E

 when i put this compact flash on Board the red LED (Sysace error) is glowin=
g=2E And iam connecting board in Windows-XP Platform=2E

So Please help me to come out of this and Let me know the Procedure you foll=
owed to successfully port Linux on ML403=2E

Best Regards=20
Rajanibabu
