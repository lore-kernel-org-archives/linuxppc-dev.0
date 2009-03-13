Return-Path: <takatz@pericle.com>
Received: from xceltech.net (mail2.xceltech.net [199.227.119.213])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 45B22DE0E9
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 10:19:54 +1100 (EST)
Received: from [70.56.244.175] (helo=[192.168.1.12])
	by xceltech.net with esmtpa (Exim 4.62)
	(envelope-from <takatz@pericle.com>) id KGGV2K-0009IX-N4
	for linuxppc-dev@ozlabs.org; Fri, 13 Mar 2009 16:42:20 -0600
Message-ID: <49BAE147.4060102@pericle.com>
Date: Fri, 13 Mar 2009 16:42:15 -0600
From: Mark Takatz <takatz@pericle.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: use generic	pci_assign_unassign_resources
References: %(message_id_url)s
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: Mark Takatz <takatz@pericle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

We're looking at the fixes you put in place for the various PCI errors 
and we think this is the solution we need for our system, a GE Fanuc CM6 
PPC board (single 8641), but your patches appear to apply either to 
2.6.24 or 2.6.25, and we have 2.6.23.  Do you know of any similar work 
done on the 2.6.23 release?

Thanks in advance for any help you can provide,

-- 
Mark J. Takatz
Pericle Communications Company
1910 Vindicator Drive, Suite 100
Colorado Springs, CO 80919
Office:  (719) 548-1170
Cell:  (719) 287-5267
Fax:  (719) 548-1211
takatz@pericle.com
