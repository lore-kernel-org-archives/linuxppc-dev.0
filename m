Message-ID: <3CC6F830.807@pacbell.net>
Date: Wed, 24 Apr 2002 11:23:44 -0700
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: Matt Porter <mporter@mvista.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Status on 405GP i2c driver
References: <20020422141601.B16319@ecam.san.rr.com> <20020423160548.A5009@home.com> <20020423182301.B19665@ecam.san.rr.com> <20020424144733.GA11949@beef.az.mvista.com> <20020424083909.C17930@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


andrew may wrote:
> On Wed, Apr 24, 2002 at 07:47:33AM -0700, Matt Porter wrote:
>
>>It's not a good idea to merge the i2c-2.6.3 support into 2_4_devel.
>>
>
> It seemed that Armins patch to the i2c list was against 2.6.3 so I deciede
> to merge that in before I merged in Armin's patch. I started doing the merge
> before you added in the files so that made things interesting. Unless you
> think 2.6.3 has some new bugs I see no reason to back out the changes in
> my tree.
>

Yes the patch sent to the i2c mailing list was against 2.6.3 since thats
their latest version.  The *.c & *.h files should be the same in both trees

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
