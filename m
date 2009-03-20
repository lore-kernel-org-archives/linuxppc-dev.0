Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-315.bluehost.com (outbound-mail-315.bluehost.com
	[67.222.54.8]) by ozlabs.org (Postfix) with SMTP id 69138DDE0F
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 12:05:35 +1100 (EST)
Message-ID: <49C2EA49.90907@dlasys.net>
Date: Thu, 19 Mar 2009 20:58:49 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org
Subject: Re: Xilinx cygwin linux cross recommendations ?
References: <49C2DC5D.6000701@dlasys.net>
	<fa686aa40903191716wa0fa4f5r15fc9c5560468a20@mail.gmail.com>
In-Reply-To: <fa686aa40903191716wa0fa4f5r15fc9c5560468a20@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Reply-To: dhlii@dlasys.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

    I have no experience with ELDK.
    Have you used it ? Do you like it ?

    When I started I mostly did a roll my own environment using crosstool.
    I would have stuck to that except I can not get uclibc and it has
not been updated in a long time.
    Crosstool-ng did not support the ppc last time I looked.
    Today I use buildroot - mostly just to build a toolchain - I have
never been able to get it to do many of the other things it is capable of.

    I am not particularly fond (serious understatement)  of "integrated
solve all the problems of the world" environments, they rarely work, and
you must think inside their box.
   
    I would be ecstatic with just a cygwin-linux-ppc-uclibc tool chain.

   
   
   

Grant Likely wrote:
> On Thu, Mar 19, 2009 at 5:59 PM, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>   
>>    Does anyone have experience sugestions for building ppc/linux apps
>> or even ppc kernels under windows.
>>     
>
> I hear rumors that there is a Windows version of ELDK.
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
