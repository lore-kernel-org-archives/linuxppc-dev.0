Return-Path: <chrispl78@yahoo.com>
Received: from smtp104.prem.mail.sp1.yahoo.com
	(smtp104.prem.mail.sp1.yahoo.com [98.136.44.59])
	by ozlabs.org (Postfix) with SMTP id 96A7BDE002
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 04:06:40 +1000 (EST)
Message-ID: <4A11A3B4.7060801@yahoo.com>
Date: Mon, 18 May 2009 11:06:44 -0700
From: Chris Plasun <chrispl78@yahoo.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: Accessing NTFS Shares from Freescale MPC8313
References: <4A0FCEAA.5000606@yahoo.com>
	<20090518171028.GA18620@b07421-ec1.am.freescale.net>
In-Reply-To: <20090518171028.GA18620@b07421-ec1.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Sun, May 17, 2009 at 01:45:30AM -0700, Chris Plasun wrote:
>> Hi,
>>
>> (I haven't found any answers in the archives)
>>
>> How would I access a NTFS shared directory from a Freescale MPC8313?
>>
>> Will Samba run on a Freescale MPC8313?
> 
> It should (and if it doesn't, file a bug with them).  
> 
> Userspace is pretty much the same at the source-code and user-interface
> level -- the answer to "how do I do X on this PPC board" is generally the
> same as the answer to "how do I do X on Linux", other than that you may
> need to compile some packages manually if they don't come with whatever
> distribution you're using.

Thanks Scott.

I did some more reading on the board and it appears that it's not as 
limited as I thought. The "custom" Linux we're running is very limited 
(so it appears) and I interpreted the board to be so as well.

I'm a Windows ASP.NET developer thrown off the deep end into Linux so 
please forgive the noob questions. After going through many post it 
appears my questions are pertinent to general Linux.

Thank you!
Chris Plasun
