Return-Path: <stevewin@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 48F95DDEE6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jun 2007 02:01:06 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5QG13GF002995
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jun 2007 12:01:03 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5QG11PR259924
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jun 2007 10:01:02 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5QG102n022152
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jun 2007 10:01:01 -0600
Received: from d03nm125.boulder.ibm.com (d03nm125.boulder.ibm.com
	[9.17.195.151])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l5QG10td022131
	for <linuxppc-embedded@ozlabs.org>; Tue, 26 Jun 2007 10:01:00 -0600
In-Reply-To: <OF6593F764.1D9AA110-ON87257305.0067371E-85257305.00688AB4@us.ibm.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Subject: Re: Katmai w/ DENX git - "init has generated signal 4" error
Message-ID: <OFBF408254.9B235C85-ON87257306.0057DC6C-85257306.0057F0B4@us.ibm.com>
From: Stephen Winiecki <stevewin@us.ibm.com>
Date: Tue, 26 Jun 2007 12:02:14 -0400
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I'm using the Denx linux-2.6-denx.git repository with a Katmai board. I 
> want to boot off a disk (initialized w/ Debian 4.0).  I've installed a 
> Promise Ultra133 Tx2 IDE controller card in the PCI slot, and configured 

> it in the kernel.    I boot this same disk w/ IDE card on other 4xx 
boards 
> without a problem (Bamboo w/ Denx 4.1 for example).  I am getting an 
error 
> "init has generated signal 4 but has no handler for it".

I believe the problem may be due to lack of HW FP on the processor(?). 
Copying an embedded 440 RFS on disk works OK.
