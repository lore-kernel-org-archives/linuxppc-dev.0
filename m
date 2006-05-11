Return-Path: <thiagogalesi@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 21B97679E7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 22:09:04 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so118892ugf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 May 2006 05:08:59 -0700 (PDT)
Message-ID: <82ecf08e0605110502pb5c061ao5cc3e04075599842@mail.gmail.com>
Date: Thu, 11 May 2006 09:02:46 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Jayanta Das" <JDas@alphion.com>
Subject: Help: Linux porting to custom target hw
In-Reply-To: <8584FDC94AFF7640B17B8A89B23B19B331C626@sbsserver.AlphionCorp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <8584FDC94AFF7640B17B8A89B23B19B331C626@sbsserver.AlphionCorp.local>
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

Ok

What is the specific problem you are having?? Based on what you said
all went well, didn't it?

Basically, I think the main thing you have to configure there is flash
location (in the kernel), to be able to use it via MTD.

Booting from NFS or Flash is pretty much effortless, configurable via cmdli=
ne.

Be more specific, so we can help you more...

Thiago

On 5/10/06, Jayanta Das <JDas@alphion.com> wrote:
>
>
> Hello:
>
> Can someone point me in the right direction for some good documentation o=
n
> the above topic. Following is what I so far have done and what I need to =
do.
>
> 1. Set up host environment based on Fedora Core 4
> 2. Downloaded 'ppc4xx' tool chain, ELDK and kernel
> 3. Built U-Boot and uImage
> 4. Flashed U-Boot on the 2nd flash on the Ocotea board (AMCC440GX PowerPC=
)
> 5. Changed the environment variable for NFS mounted root fs and other MAC
> and IP addresses as needed
> 6. TFTP uImage at 400000
> 7. bootm and kernel boots all right with root fs mounted on the host
>
> I am expecting my hardware based on 440GX end of the month. I told the HW
> engineer to follow the peripheral i/f as much possible close to the ref.
> design. We are putting 32MB of Flash and 256MB of RAM.
>
> I need some guidance so that I can port U-Boot and the kernel (minimal
> changes) so that I can bring up the board initially with root fs NFS mint=
ed
> and later on the RAMDISK.
>
> Appreciate the help.
>
> Regards.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
