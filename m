Return-Path: <cfriesen@nortelnetworks.com>
Received: from zcars04e.nortelnetworks.com (zcars04e.nortelnetworks.com
	[47.129.242.56]) by ozlabs.org (Postfix) with ESMTP id 13A692BDB8
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2004 15:13:11 +1000 (EST)
Message-ID: <416B67DE.3050909@nortelnetworks.com>
Date: Mon, 11 Oct 2004 23:13:02 -0600
From: Chris Friesen <cfriesen@nortelnetworks.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <416709B8.8080107@vision.caltech.edu>
	<4A39EEF2-1B6B-11D9-AE5A-000A95A4DC02@kernel.crashing.org>
In-Reply-To: <4A39EEF2-1B6B-11D9-AE5A-000A95A4DC02@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Arrigo Benedetti <arrigo@bologna.vision.caltech.edu>,
	linuxppc-dev@ozlabs.org
Subject: Re: Update frequency of Time Base reg?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> I'm looking for information about the update frequency of the Time 
>> Base register
>> for the latest dual G5 Powermac and Xserve models.
>> By the way, what is the best way to find this kind of information?
> 
> 
> Look in the device-tree.

Look where in which device tree?

dmesg shows it, but I wasn't aware of any reliable way to get it from userspace 
on all ppc boxes.

Chris
