Return-Path: <stevewin@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 33E21DDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 01:29:30 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4MFTOfK022374
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 11:29:24 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4MFTO3i267780
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 09:29:24 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4MFTNWh026115
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 09:29:23 -0600
In-Reply-To: <a9951d2a0705201954k33c06fc8n6912587a45d66c1d@mail.gmail.com>
To: rogelio.serrano@gmail.com
MIME-Version: 1.0
Subject: Re: powerpc 750cl availability
Message-ID: <OFFC1F7F41.FBC6131F-ON872572E3.0054328A-852572E3.005511BA@us.ibm.com>
From: Stephen Winiecki <stevewin@us.ibm.com>
Date: Tue, 22 May 2007 11:29:22 -0400
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

FYI, here are the part numbers for the IBM 750CL/TSI110 evaluation board 
('Hackberry') / evaluation kit which you should be able to use with 
distributers like Avnet to identify the product:

IBM kit p/n - 41K7364
OEM p/n - IBM25EB750CLWINHCK00

The kit includes the board schematics.  The Linux 'Holly' platform 
definition which was recently added to /powerpc supports Hackberry as well 
(Holly =750CL/TSI109).

Thanks,

Steve
