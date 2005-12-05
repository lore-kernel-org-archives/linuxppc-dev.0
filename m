Return-Path: <glikely@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.198])
	by ozlabs.org (Postfix) with ESMTP id 9B7176884B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Dec 2005 03:52:12 +1100 (EST)
Received: by zproxy.gmail.com with SMTP id j2so939644nzf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 05 Dec 2005 08:52:11 -0800 (PST)
Message-ID: <43947034.3000402@gmail.com>
Date: Mon, 05 Dec 2005 09:52:04 -0700
From: Grant Likely <glikely@gmail.com>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@gmail.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <528646bc050910003630c25dca@mail.gmail.com>	
	<87vf0wp84r.fsf@p4.48ers.dk>	
	<528646bc05091923462e07de0c@mail.gmail.com>
	<9305ca410512050558o4778824as5a5b24a9bfeccc75@mail.gmail.com>
In-Reply-To: <9305ca410512050558o4778824as5a5b24a9bfeccc75@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [PATCH 1/2] Move Virtex-II Pro / ML300 port over to the platform
 bus.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter Korsgaard wrote:

>On 9/20/05, Grant Likely <glikely@gmail.com> wrote:
>  
>
>>On 9/20/05, Peter Korsgaard <jacmet@sunsite.dk> wrote:
>>    
>>
>>>>>>>>" " == Grant Likely <glikely@gmail.com> writes:
>>>>>>>>                
>>>>>>>>
>>>Hi,
>>>
>>> > This is a large patch that moves the ML300 to the platform bus.
>>> > It also isolates most of the linux tree from changes to the
>>> > xparameters.h file.  Ultimately, the goal is to move everything
>>> > over to the flattened device tree for telling the kernel about
>>> > devices.  That way xparameters.h can go away entirely for the
>>> > kernel proper.  (Isolated to the bootloader)
>>>      
>>>
>
>Hi,
>
>Any news on submitting this to mainline?
>  
>

Yeah, I'm back working on it again after being pulled away on consulting
priorities.  I hope to have a public git tree up soon, and I'll be
sending patches to mainline shortly thereafter.

Cheers
g.
