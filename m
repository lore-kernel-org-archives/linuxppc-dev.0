Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <473FD762-FB04-4B63-93E9-11931492AC60@freescale.com>
References: <17153.8284.3721.188488@cargo.ozlabs.ibm.com>
	<473FD762-FB04-4B63-93E9-11931492AC60@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <62a65a7989df38a7e4b1400150dcb2e5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 16 Aug 2005 11:44:33 +0200
To: Kumar Gala <kumar.gala@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc64-dev@ozlabs.org, David Edelsohn <dje@watson.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: CONFIG_FRAME_POINTER on ppc/ppc64?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Because -fomit-frame-pointer and -fno-omit-frame-pointer have no
>> effect on ppc or ppc64, I assume. :)
>
> I'm assuming that's a guess.  The reason I ask that is my memory 
> serves correctly r31 is used as the frame pointer if compiled that 
> way.  Maybe some GCC expert can chime in.  I'll copy David Edelsohn 
> and see if I get a response :)

Yes, GPR31 is used as frame pointer.  All optimization
levels other than -O0 enable -fomit-frame-pointer.  But
-fno-omit-frame-pointer certainly works.


Segher
