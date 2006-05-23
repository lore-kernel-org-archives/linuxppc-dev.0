Return-Path: <jfaslist@yahoo.fr>
Message-ID: <447338BC.8010701@yahoo.fr>
Date: Tue, 23 May 2006 18:30:52 +0200
From: jfaslist <jfaslist@yahoo.fr>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: Maple: killing a  process that causes a machine check exception
References: <44732357.4000506@yahoo.fr> <20060523151541.GB10468@krispykreme>
	<447333BF.6060306@yahoo.fr> <20060523162348.GC5938@krispykreme>
In-Reply-To: <20060523162348.GC5938@krispykreme>
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


>>In my case I _need_ the process to be killed, as it is making a VME bus 
>>error. / PCI target-abort.
>>I am starting to get desperate. I have been working for several month 
>>with IBM to get a solution on machine check related issues on the Maple. 
>>First, the Maple was hanging hard. Now that this is fixed, I need the 
>>Linux ME to kill the offending process!
>>My feeling now, is that I am really starting to have it w/ the ppc64!
>>    
>>
>
>Sounds like you need a Maple specific machine check handler. My point is
>we cant merge a fix like that because it affects every powerpc arch out
>there, all with different machine check handling requirements.
>
>  
>
understood. thanks. sorry for letting out a little steam
-jean-francois simon


	

	
		
___________________________________________________________________________ 
Yahoo! Mail réinvente le mail ! Découvrez le nouveau Yahoo! Mail et son interface révolutionnaire.
http://fr.mail.yahoo.com
