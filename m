Return-Path: <cedric.pradalier@inrialpes.fr>
Date: Wed, 25 Jan 2006 21:27:02 +1000
From: Cedric Pradalier <cedric.pradalier@inrialpes.fr>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH 001/001 Updated again] PMAC HD runtime blinking control
Message-Id: <20060125212702.360ba063.cedric.pradalier@inrialpes.fr>
In-Reply-To: <jey814y3az.fsf@sykes.suse.de>
References: <20060122121907.792abc72.cedric.pradalier@free.fr>
	<1137898193.12998.83.camel@localhost.localdomain>
	<20060123233823.3f0dbad5.cedric.pradalier@inrialpes.fr>
	<1138024037.4907.24.camel@localhost.localdomain>
	<20060124073133.5cab0e93.cedric.pradalier@inrialpes.fr>
	<1138057827.4907.30.camel@localhost.localdomain>
	<20060124222513.48ef0276.cedric.pradalier@inrialpes.fr>
	<jey814y3az.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

According to Andreas Schwab, on Wed, 25 Jan 2006 12:06:44
+0100, 
>Cedric Pradalier <cedric.pradalier@inrialpes.fr> writes:
>
>> @@ -427,6 +432,15 @@ static void pmac_ide_kauai_selectproc(id
>>  
>>  #ifdef CONFIG_BLK_DEV_IDE_PMAC_BLINK
>>  
>> +MODULE_AUTHOR("Paul Mackerras & Ben. Herrenschmidt");
>> +MODULE_DESCRIPTION("Support for IDE interfaces on PowerMacs");
>> +MODULE_LICENSE("GPL");
>> +
>> +static int activity_led = 0;
>
>No need to zero-initialize a static variable.

On the other hand, the cost is minor for an increased
readability and a behavior which does not rely on any 
assumption on the compiler (or even the C specification).

I tend to favor readability first in my coding.

Cheers
--
Cedric
