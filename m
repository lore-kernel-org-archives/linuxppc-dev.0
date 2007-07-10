Return-Path: <psyphi@gmail.com>
Message-ID: <13b81f0c0707100641i56e08bd3n7c7911782a81628a@mail.gmail.com>
Date: Tue, 10 Jul 2007 15:41:25 +0200
From: ThomasB <psyphi@gmail.com>
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [kernel-2.6.19]Marvell GT-64260 and Ethernet
In-Reply-To: <20070710132207.12018.qmail@farnsworth.org>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_181598_5769342.1184074885982"
References: <13b81f0c0707092336r5c7f4996u6f9c73d95c63bdc6@mail.gmail.com>
	<20070710132207.12018.qmail@farnsworth.org>
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_181598_5769342.1184074885982
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>Isn't the ethernet the same on the 64260, 64360, 64460?
>
> There's definitely a driver for 6436x and above..

I just try it, it doesn't work, I receive without end the message:
mv643xx PHY read timeout, port 0

> I believe that Steve Hill <sjhill@realitydiluted.com> has patched
> the mv643xx_eth driver to work with the 64260 and plans to submit
> the patches.
That's means the patch isn't yet ready?
I will try to contact him.

It's nevertheless odd, I read about a file named gt64260_eth.c during my
search on the internet.But I wasn't able to find it :(.

Thanks for you help

-- 
ThomasB
http://psyphi.zeblog.com/

------=_Part_181598_5769342.1184074885982
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

&gt;Isn&#39;t the ethernet the same on the 64260, 64360, 64460?<br>&gt;<br>&gt; There&#39;s definitely a driver for 6436x and above..<br><br>I just try it, it doesn&#39;t work, I receive without end the message:<br>mv643xx PHY read timeout, port 0
<br><br>&gt; I believe that Steve Hill &lt;<a href="mailto:sjhill@realitydiluted.com">sjhill@realitydiluted.com</a>&gt; has patched<br>&gt; the mv643xx_eth driver to work with the 64260 and plans to submit<br>&gt; the patches.
<br>That&#39;s means the patch isn&#39;t yet ready?<br>I will try to contact him.<br><br>It&#39;s nevertheless odd, I read about a file named gt64260_eth.c during my search on the internet.But I wasn&#39;t able to find it :(.
<br><br>Thanks for you help<br><br>-- <br>ThomasB<br><a href="http://psyphi.zeblog.com/">http://psyphi.zeblog.com/</a>

------=_Part_181598_5769342.1184074885982--
