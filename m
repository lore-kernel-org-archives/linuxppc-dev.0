Return-Path: <dalang@cs.ubc.ca>
Received: from badenpowell.cs.ubc.ca (badenpowell.cs.ubc.ca [142.103.6.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3891867B55
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2005 05:46:44 +1000 (EST)
Date: Wed, 15 Jun 2005 11:16:41 -0700 (PDT)
From: Dustin Lang <dalang@cs.ubc.ca>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20050615180011.GB21165@gate.ebshome.net>
Message-ID: <Pine.LNX.4.60.0506151114280.28342@tin.icics.ubc.ca>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B36@exnet.3il.fr>
	<20050615180011.GB21165@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, Garcia J?r?mie <GARCIAJ@3il.fr>
Subject: Re: RE : Error while opennig device file
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Also - does it work from the command line?  Do both mknod commands work? 
When you "ls -l /dev/test{1,2}" , what do you get?  What happens when you 
"cat /dev/test1" or "echo > /dev/test1" ?

Cheers,
dstn.


>> I'm sorry but this is a "copy to mail" error.
>> Here is the right code:
>>
>> ret_val = system("mknod -m 777 /dev/test1 c 122 1");
>> ret_val = system("mknod -m 777 /dev/test2 c 122 2");
>>
>> file_desc1 = open("/dev/test1", O_RDWR);
>> file_desc2 = open("/dev/test2", O_RDWR);
