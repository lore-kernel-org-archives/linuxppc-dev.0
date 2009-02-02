Return-Path: <gjb@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A44FBDDF2C
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 03:41:49 +1100 (EST)
Message-ID: <49872268.10003@semihalf.com>
Date: Mon, 02 Feb 2009 17:42:16 +0100
From: Grzegorz Bernacki <gjb@semihalf.com>
MIME-Version: 1.0
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: [PATCH] Add support for the digsy MTC board.
References: <1233329630876-git-send-email-gjb@semihalf.com>	<fa686aa40901300859t4da76ce3hf943adc48abb9b9c@mail.gmail.com>
	<4986EC33.9000600@semihalf.com> <49871C8C.8030200@matrix-vision.de>
In-Reply-To: <49871C8C.8030200@matrix-vision.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andre Schwarz wrote:
>>
>> BTW,
>> I noticed that there are some problems with mounting file system
>> over NFS on Linux-2.6.29-rc3, I see following messages:
>> ...
>> [  339.813807] nfs: server 192.168.1.1 not responding, still trying
>> [  339.832144] nfs: server 192.168.1.1 OK
>> ...
>>
>> I haven't noticed in on Linux-2.6.29-rc2. Is there any known problem?
>>
>>   
> We also had this kind of problem - after feeding some nfs options it
> worked :
> 
> rsize=8192,wsize=8192,soft,intr,tcp,nolock
> 
> 
> Cheers,
> Andre

Thanks,
it seems that it helps.

regards,
Grzesiek
