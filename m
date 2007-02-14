Return-Path: <setsu@emi.yamaha.co.jp>
Received: from mxr02.yamaha.co.jp (mxr02.yamaha.co.jp [133.176.220.113])
	by ozlabs.org (Postfix) with ESMTP id 8348DDDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Feb 2007 18:12:11 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <loom.20070214T072955-792@post.gmane.org>
References: <loom.20070214T072955-792@post.gmane.org>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <97C76137-FF67-4145-BAF3-1AB3290F4D05@emi.yamaha.co.jp>
From: Suzuki Takashi <setsu@emi.yamaha.co.jp>
Subject: Re: 'make' behaviour in BuildRoot
Date: Wed, 14 Feb 2007 16:01:49 +0900
To: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

How about mounting the cramfs image and append 'test23' to '/usr'
inside mounted image, then unmount the image.

If the image is compressed,
  uncompress - mount - append - unmount - compress
procedure is needed, of course.

Thanks,

-- T.Suzuki

On Feb 14, 2007, at 3:32 PM, Daniel Ng wrote:
> In particular, when I run the BuildRoot 'make', I end up with the  
> final cramfs
> image which is great!
>
> However, if I want to add a new file to the Root FS (eg. if I want  
> to add the
> file 'test23' to '/usr') it seems that I have to do a 'make clean'  
> first, and
> then run 'make' ie. a full rebuild.
