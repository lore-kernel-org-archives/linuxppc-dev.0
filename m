Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3DF6A1007D1
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2011 12:43:20 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <bounces@nabble.com>) id 1Px8Qm-0005ay-J2
	for linuxppc-dev@ozlabs.org; Tue, 08 Mar 2011 17:43:16 -0800
Message-ID: <31102807.post@talk.nabble.com>
Date: Tue, 8 Mar 2011 17:43:16 -0800 (PST)
From: Vasanth Ragavendran <ragavendrapec@yahoo.co.in>
To: linuxppc-dev@ozlabs.org
Subject: Re: Mpc8315erdb openvpn segmentation fault
In-Reply-To: <20110308125259.73d3094b@schlenkerla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <31086738.post@talk.nabble.com>
	<20110307142207.6e879798@schlenkerla>
	<31094242.post@talk.nabble.com>
	<20110308125259.73d3094b@schlenkerla>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Thanks again Scott. That was really helpful. Actually i forgot to mention
that i had created an ext2 ramdisk file system and it was non-persistent.
and then i changed the file system to jffs2 and it is persistent. so my
question is why is that the ext2 ramdisk is non-persistent? and what needs
to be changed in order to make it persistent. thanks again for prompt
response..


Scott Wood-2 wrote:
> 
> On Mon, 7 Mar 2011 20:28:32 -0800
> Vasanth Ragavendran <ragavendrapec@yahoo.co.in> wrote:
> 
>> 
>> Thanks a ton Scott. Actually i was working with the same version of the
>> kernel on both the boards.
>> it was 2.6.29.6. neither i changed the u-boot. it was the same in both.
>> however i recompiled the kernel and i installed on both the boards and it
>> worked fine! :) thanks again for responding. however i've another
>> question.
>> my filesystem in the board is non-persistent i.e. the files i create are
>> erased after i reboot i know the files are getting stored in RAM and i
>> wish
>> to make them persistent. what do i need to do for this? should i create a
>> separate partition in the flash and load certain files into that
>> partition?
>> or how should i make it persistent so that files stay beyond reboot!
>> thanks
>> again! eagerly awaiting your response.
> 
> Yes, you should create a filesystem (e.g. jffs2) on a flash partition.
> 
> -Scott
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://old.nabble.com/Mpc8315erdb-openvpn-segmentation-fault-tp31086738p31102807.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
