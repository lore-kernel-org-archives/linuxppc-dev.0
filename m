Return-Path: <segher@kernel.crashing.org>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C90A32BDB5
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Oct 2004 19:52:52 +1000 (EST)
In-Reply-To: <416709B8.8080107@vision.caltech.edu>
References: <416709B8.8080107@vision.caltech.edu>
Mime-Version: 1.0 (Apple Message framework v619)
Message-Id: <4A39EEF2-1B6B-11D9-AE5A-000A95A4DC02@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Mon, 11 Oct 2004 11:52:40 +0200
To: Arrigo Benedetti <arrigo@bologna.vision.caltech.edu>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Update frequency of Time Base reg?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I'm looking for information about the update frequency of the Time 
> Base register
> for the latest dual G5 Powermac and Xserve models.
> By the way, what is the best way to find this kind of information?

Look in the device-tree.


Segher
