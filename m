Return-Path: <bwarren@qstreams.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id 7F0D4DDE29
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Oct 2007 08:04:38 +1000 (EST)
Message-ID: <472112F2.6080901@qstreams.com>
Date: Thu, 25 Oct 2007 18:04:34 -0400
From: Ben Warren <bwarren@qstreams.com>
MIME-Version: 1.0
To: Michael Brian Willis <willis@arlut.utexas.edu>
Subject: Re: MPC85xx and linux IDE driver
References: <1192213784.4862.48.camel@louie> <470FCF8A.1000504@qstreams.com>	
	<1192643237.4929.41.camel@louie> <471657FB.3040806@qstreams.com>
	<1193348964.29111.71.camel@louie>
In-Reply-To: <1193348964.29111.71.camel@louie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Michael Brian Willis wrote:
> On Wed, 2007-10-17 at 14:44 -0400, Ben Warren wrote:
>
>   
>> This device driver is a platform driver, so you need to register a 
>> platform device somewhere in your board-specific init code that contains 
>> the hardware details (memory mapping and IRQ #).  
>>     
>
> After modifying your init code and putting it in my board specific ".c"
> file everything is working great. 
>
>   
Fantastic!
> Thanks again for all of your help!
>
>   
You're welcome.
