Return-Path: <gjalt007@chello.nl>
Received: from amsfep15-int.chello.nl (amsfep15-int.chello.nl [213.46.243.27])
	by ozlabs.org (Postfix) with ESMTP id 5FF5367A01
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 May 2005 07:04:25 +1000 (EST)
Received: from [192.168.1.10] (really [80.57.11.99]) by amsfep15-int.chello.nl
	(InterMail vM.6.01.04.04 201-2131-118-104-20050224) with ESMTP
	id <20050526210421.SDTR1936.amsfep15-int.chello.nl@[192.168.1.10]>
	for <linuxppc-embedded@ozlabs.org>; Thu, 26 May 2005 23:04:21 +0200
Message-ID: <429639D5.20609@chello.nl>
Date: Thu, 26 May 2005 23:04:21 +0200
From: Theo Gjaltema <gjalt007@chello.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Dynamic libraries do not work
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have a linux 2.4.20 kernel running, but the files in the ramdisk fail 
to execute if they are dynamically build.
The whole system stops (debuggers shows that it crashed while in an erea 
where no flash/ram is present.
Anyone an idea?
There is nog difference between the use of a ramdisk or an nfs mounted 
root filesystem.

Greetings,
    Theo.
