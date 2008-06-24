Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82704DE23E
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jun 2008 02:34:13 +1000 (EST)
In-Reply-To: <0DCAAAC2-52AB-4704-98C0-4E9235C3AC88@kernel.crashing.org>
References: <20080624105750.0610170295@localhost.localdomain>
	<0DCAAAC2-52AB-4704-98C0-4E9235C3AC88@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <440cfd52acd1f29327653d8197c0c686@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/9] powerpc: Add macros to access floating point
	registers in thread_struct.
Date: Tue, 24 Jun 2008 18:33:52 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
>> -				   &target->thread.fpr, 0, -1);
>> +				   target->thread.fpr, 0, -1);
>
> is there a reason we can drop the '&'?

Yes, .fpr is an array.  C is _such_ a fun language, heh.


Segher
