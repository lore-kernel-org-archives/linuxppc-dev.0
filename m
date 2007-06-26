Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9611ADDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2007 01:11:32 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l5QF6VEH018007
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 11:06:31 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5QFBRaj267048
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 09:11:28 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5QFBRXj021158
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 09:11:27 -0600
Date: Tue, 26 Jun 2007 10:11:26 -0500
To: xu chen <chenxurcy@yahoo.com.cn>
Subject: Re: Who can help me with my NFS?
Message-ID: <20070626151126.GC4482@austin.ibm.com>
References: <947266.20019.qm@web92009.mail.cnb.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <947266.20019.qm@web92009.mail.cnb.yahoo.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 26, 2007 at 01:59:33PM +0800, xu chen wrote:
> I ported my opb_ethernet driver to the ml403 board, with the reference system provided by Xilinx Co. Now I can ping the host with the board, and can also ping the board with PC. But I can't mount the NFS of my PC. The host configuration is correct,  and the host can also be mounted by other PCs. Here is my tcpdump log when the board mount the PC's NFS, PC's IP: 192.168.1.107; board's IP: 192.168.1.134

Does telnet work? Can you ftp?

I had problems with nfs once when the device driver failed to compute the 
checksum on the packets. This allowed some things to work, but not
others.  Does tcp work, but udp is borken, or are tehy both broken?

--linas
