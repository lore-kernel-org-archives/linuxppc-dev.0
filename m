Return-Path: <segher@kernel.crashing.org>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8E6972BDDC
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2004 19:04:18 +1000 (EST)
In-Reply-To: <416B67DE.3050909@nortelnetworks.com>
References: <416709B8.8080107@vision.caltech.edu>
	<4A39EEF2-1B6B-11D9-AE5A-000A95A4DC02@kernel.crashing.org>
	<416B67DE.3050909@nortelnetworks.com>
Mime-Version: 1.0 (Apple Message framework v619)
Message-Id: <AB928930-1C2D-11D9-925F-000A95A4DC02@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 12 Oct 2004 11:04:06 +0200
To: Chris Friesen <cfriesen@nortelnetworks.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org,
	Arrigo Benedetti <arrigo@bologna.vision.caltech.edu>
Subject: Re: Update frequency of Time Base reg?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Look where in which device tree?

In the "timebase-frequency" property under any CPU node.


Segher
