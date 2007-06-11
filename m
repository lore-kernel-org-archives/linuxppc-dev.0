Return-Path: <j.borkhuis@dutchspace.nl>
Received: from kirk.dutchspace.nl (kirk.dutchspace.nl [193.200.147.14])
	by ozlabs.org (Postfix) with ESMTP id 1932EDDEDC
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Jun 2007 19:04:18 +1000 (EST)
Received: from [10.21.30.78] (snitkin.dutchspace.nl [10.21.30.78])
	by kirk.dutchspace.nl (8.11.7p1+Sun/8.10.2) with ESMTP id l5B8kQN21627
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 11 Jun 2007 10:46:26 +0200 (MEST)
Message-ID: <466D0C56.3080804@dutchspace.nl>
Date: Mon, 11 Jun 2007 10:48:22 +0200
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Question on nfsroot shared by multiple targets
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

I have the following setup: one server, with DHCP server and NFS-root 
for an embedded target. With one target this works OK, but now I want to 
add another target. The problem I see is that both targets are going to 
write into the same logfiles and lockfiles.
I did setup the DHCP server in such a way that the NFS-root of the 
target points to /nfsroot/<last octet of IP address>. But for this to 
work I need a copy of the complete tree for each target board. I would 
prefer to have only one tree for all targets, as this saves the effort 
of keeping all trees in sync.
I could create a smaller NFS-root per target, with only /etc, /var and 
some other directories and mount-points and mount all directories from a 
central nfsroot using the local fstab in /etc. This could work for /var, 
but I would still need to keep /etc in sync.

Is there another way to do this, or is this the correct way to setup a 
multi-target system?

Kind regards,
    Johan Borkhuis
