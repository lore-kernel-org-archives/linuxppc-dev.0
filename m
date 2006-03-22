Return-Path: <mguertin@ppckernel.org>
In-Reply-To: <1142992999.12137.69.camel@localhost.localdomain>
References: <82FEFC77-5EDB-4349-B935-AD422913F3F7@laposte.net>
	<1142992999.12137.69.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FCCB4002-AA48-437F-98F0-4E284CBB1818@ppckernel.org>
From: Mark Guertin <mguertin@ppckernel.org>
Subject: Re: Running Linux 2.6.16 and Xorg 7.0 on iMac G5 rev C (iSight)
Date: Wed, 22 Mar 2006 11:33:48 -0500
To: =?ISO-8859-1?Q?=C9tienne_Bersac?= <bersace03@laposte.net>
Cc: Linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	ubuntu-devel@lists.ubuntu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 21-Mar-06, at 9:03 PM, Benjamin Herrenschmidt wrote:

>
>>   - Get Ben's kernel at http://bersace03.free.fr/pub/iMac%20G5/
>> vmlinux.bz2 (mirror of http://gate.crashing.org/~benh/vmlinux.bz2).
>> bunzip2 it at /.
>
> Don't do that ! :)
>
> There is no such thing as benh's kernels :) that's long gone. In  
> fact, I
> just removed the above one from the site... it was just a build to  
> help
> you. 2.6.16 should work on this machine, if you need a pre-build  
> version
> of it, try to get somebody on this list or post yourself one somewhere
> but don't spread the idea that there is still such a thing as "benh's
> kernel" :)

If you're ever looking for prebuilt kernels for powerpc check out  
http://ppckernel.org/

Many prebuilt (vanilla, some custom kernels).  We're always willing  
to take on more configs as well (like ubuntu builds).  if you want to  
add some get in touch with me offlist and we can get you setup.

Makes for good regression testing as well as we keep an archive of  
the kernels built.

Mark
