Return-Path: <bounces@nabble.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 56F83B6F0B
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Mar 2011 13:46:12 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by sam.nabble.com with esmtp (Exim 4.69)
	(envelope-from <bounces@nabble.com>) id 1PyxnM-00048l-Jz
	for linuxppc-dev@ozlabs.org; Sun, 13 Mar 2011 19:46:08 -0700
Message-ID: <31140838.post@talk.nabble.com>
Date: Sun, 13 Mar 2011 19:46:08 -0700 (PDT)
From: Vasanth Ragavendran <ragavendrapec@yahoo.co.in>
To: linuxppc-dev@ozlabs.org
Subject: Re: Mpc8315erdb openvpn segmentation fault
In-Reply-To: <31103965.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <31086738.post@talk.nabble.com>
	<20110307142207.6e879798@schlenkerla>
	<31094242.post@talk.nabble.com>
	<20110308125259.73d3094b@schlenkerla>
	<31103965.post@talk.nabble.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Thanks scott! my question must have been very silly to u! thanks for replying
to it patiently!!!

Vasanth Ragavendran wrote:
> 
> Thanks again Scott. That was really helpful. Actually i forgot to mention
> that i had created an ext2 ramdisk file system and it was non-persistent
> (the mount point was /dev/ram for this ext2 ramdisk filesystem). and then
> i changed the file system to jffs2 and it is persistent (and the mount
> point was /dev/mtdblock1 for jffs2 file system). so my question is why is
> that the ext2 ramdisk is non-persistent? is it because of the mount point
> /dev/ram and what needs to be changed in order to make it persistent.
> thanks again for prompt response.. 
> 
> 
> Scott Wood-2 wrote:
>> 
>> On Mon, 7 Mar 2011 20:28:32 -0800
>> Vasanth Ragavendran <ragavendrapec@yahoo.co.in> wrote:
>> 
>>> 
>>> Thanks a ton Scott. Actually i was working with the same version of the
>>> kernel on both the boards.
>>> it was 2.6.29.6. neither i changed the u-boot. it was the same in both.
>>> however i recompiled the kernel and i installed on both the boards and
>>> it
>>> worked fine! :) thanks again for responding. however i've another
>>> question.
>>> my filesystem in the board is non-persistent i.e. the files i create are
>>> erased after i reboot i know the files are getting stored in RAM and i
>>> wish
>>> to make them persistent. what do i need to do for this? should i create
>>> a
>>> separate partition in the flash and load certain files into that
>>> partition?
>>> or how should i make it persistent so that files stay beyond reboot!
>>> thanks
>>> again! eagerly awaiting your response.
>> 
>> Yes, you should create a filesystem (e.g. jffs2) on a flash partition.
>> 
>> -Scott
>> 
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>> 
>> 
> 
> 

-- 
View this message in context: http://old.nabble.com/Mpc8315erdb-openvpn-segmentation-fault-tp31086738p31140838.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
