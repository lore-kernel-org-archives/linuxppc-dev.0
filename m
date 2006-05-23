Return-Path: <jfaslist@yahoo.fr>
Message-ID: <447333BF.6060306@yahoo.fr>
Date: Tue, 23 May 2006 18:09:35 +0200
From: jfaslist <jfaslist@yahoo.fr>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: Maple: killing a  process that causes a machine check exception
References: <44732357.4000506@yahoo.fr> <20060523151541.GB10468@krispykreme>
In-Reply-To: <20060523151541.GB10468@krispykreme>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc64-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
What do you mean by synchronous? Do you mean that the current process 
may no be not the one that caused the ME?
In my case I _need_ the process to be killed, as it is making a VME bus 
error. / PCI target-abort.
I am starting to get desperate. I have been working for several month 
with IBM to get a solution on machine check related issues on the Maple. 
First, the Maple was hanging hard. Now that this is fixed, I need the 
Linux ME to kill the offending process!
My feeling now, is that I am really starting to have it w/ the ppc64!

-jfs

Anton Blanchard wrote:

>>By  applying the following mods (plse see below), i was able to have a 
>>user process that caused a machine check exception to be terminated (on 
>>a Maple platform), as expected. I was wondering why the PPC64 had a 
>>different ME handling than PPC which does send the SIGBUS to the process?
>>    
>>
>
>Not all machine checks are synchronous so we cant always do this. From
>memory the ppc64 version will panic if the machine check wasnt
>synchronous.
>
>Anton
>
>  
>

	

	
		
___________________________________________________________________________ 
Yahoo! Mail réinvente le mail ! Découvrez le nouveau Yahoo! Mail et son interface révolutionnaire.
http://fr.mail.yahoo.com
