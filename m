Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <17153.8284.3721.188488@cargo.ozlabs.ibm.com>
References: <17153.8284.3721.188488@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <473FD762-FB04-4B63-93E9-11931492AC60@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 15 Aug 2005 22:41:03 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Edelsohn <dje@watson.ibm.com>, linuxppc64-dev@ozlabs.org
Subject: Re: CONFIG_FRAME_POINTER on ppc/ppc64?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 15, 2005, at 6:08 PM, Paul Mackerras wrote:

>> Is there any reason we dont allow building with frame pointers on  
>> ppc/
>>
>
>
>> ppc64?
>>
>
> Because -fomit-frame-pointer and -fno-omit-frame-pointer have no
> effect on ppc or ppc64, I assume. :)

I'm assuming that's a guess.  The reason I ask that is my memory  
serves correctly r31 is used as the frame pointer if compiled that  
way.  Maybe some GCC expert can chime in.  I'll copy David Edelsohn  
and see if I get a response :)

- kumar
