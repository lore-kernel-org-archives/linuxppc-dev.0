Return-Path: <rachita@in.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CA694DE044
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Dec 2006 04:55:55 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kBKHtpep012323
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 12:55:51 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kBKHtp8l296754
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 12:55:51 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kBKHtpQA010893
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 12:55:51 -0500
Received: from localhost.localdomain ([9.124.35.47])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	kBKHto8N010824
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 12:55:50 -0500
Date: Wed, 20 Dec 2006 23:28:43 +0530
From: Rachita Kothiyal <rachita@in.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Listing virtual devices on power
Message-ID: <20061220175843.GA6217@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Reply-To: rachita@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

Since 'lspci' will not list down the virtual devices configured on a 
Power box, I was wondering if there exists some tool(or work in progress)
which would achieve this for virtual devices.

I am trying to implement this as a command in the 'crash' tool. 
I traverse the list of the vio devices, starting with the vio_bus_device 
as the parent node. But I am unable to find where the information regarding 
'class' and 'Vendor' is stored. I looked at the class entry in the struct 
device, but it turned out to be NULL. 

Any pointers would be of great help. Please Cc me as I am not subscribed
to the list.


Thanks
Rachita
