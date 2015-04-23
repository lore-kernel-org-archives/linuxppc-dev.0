Return-Path: <intermediadc@hotmail.com>
Received: from BLU004-OMC1S5.hotmail.com (blu004-omc1s5.hotmail.com
 [65.55.116.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77AA11A0CB2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 01:52:12 +1000 (AEST)
Message-ID: <BLU436-SMTP15211CBC421263950187E16C8ED0@phx.gbl>
Date: Thu, 23 Apr 2015 17:46:48 +0200
From: Luigi Burdo <intermediadc@hotmail.com>
MIME-Version: 1.0
To: Wolfram Sang <wsa@the-dreams.de>, larrystotler@netscape.net
Subject: Re: [opensuse-ppc] HELP: test kernel patches on the real thing
References: <20150416135014.GE913@katana>
 <14cd96df76d-41ad-451c9@webprd-m95.mail.aol.com>
 <20150423153758.GB2795@katana>
In-Reply-To: <20150423153758.GB2795@katana>
Content-Type: multipart/alternative;
 boundary="------------060105030906060907050908"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--------------060105030906060907050908
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Jo guys
i can try if you need to help.
I have a Quad G5 with RadeonHd on it ... Opensuse 13.2 is running on it
on Qemu 64 Kvm machine hosted by Lubuntu 14.04

On 23/04/15 17:37, Wolfram Sang wrote:
> On Mon, Apr 20, 2015 at 08:43:24PM -0400, larrystotler@netscape.net wrote:
>> -----Original Message-----
>> From: Wolfram Sang <wsa@the-dreams.de>
>>  
>> Quoted from the opensuse-ppc mailing list
>>
>>> I'm Wolfram Sang, maintainer of the I2C subsystem of the Linux Kernel. I
>>> want to get rid of an ancient mechanism in the I2C core which was used in the
>>> 2.4 era. There are only two users left; drivers for old Macintosh computers I
>>> don't have access to. So, I tried to emulate the behaviour on an ARM board and
>>> wrote a replacement for the old mechanism which works fine here. Now, I wonder
>>> if there are people willing to test these patches on the real thing? This would
>>> be much appreciated!
>> I have a bunch of older macs but none currently has linux and/or a current version of linux on them.  
>>
>> What models do you need tested?  Can you point me to a quick easy to install distro?  I usually use openSUSE but I think Fedora has a ppc port now as well.
>>
>> I only have 32bit macs.  I have:
>>
>> iMac DV 400Mhz
>> PowerMac G4 Digital Audio 466Mhz
>> 2 - PowerMac G3 Blue & Whites (one with a G4 I THINK).
>> PowerMac 9600
>> PowerMac 9500
>> PowerMac 6500
>> PowerMac 6400
>> PowerMac G3 All In One Beige.
>> PowerBook G3 Wallstreet
> Thank you for the offer! I am still in the process to find out which
> machines are "windtunnel" and which ones are "keywest". I thought this
> would be easy once I found some Mac owners, but seems I was wrong...
>
> I'll let you know if one of your machines could become useful.
>
> Thanks again,
>
>    Wolfram
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


--------------060105030906060907050908
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    Jo guys<br>
    i can try if you need to help.<br>
    I have a Quad G5 with RadeonHd on it ... Opensuse 13.2 is running on
    it on Qemu 64 Kvm machine hosted by Lubuntu 14.04<br>
    <br>
    <div class="moz-cite-prefix">On 23/04/15 17:37, Wolfram Sang wrote:<br>
    </div>
    <blockquote cite="mid:20150423153758.GB2795@katana" type="cite">
      <pre wrap="">On Mon, Apr 20, 2015 at 08:43:24PM -0400, <a class="moz-txt-link-abbreviated" href="mailto:larrystotler@netscape.net">larrystotler@netscape.net</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">-----Original Message-----
From: Wolfram Sang <a class="moz-txt-link-rfc2396E" href="mailto:wsa@the-dreams.de">&lt;wsa@the-dreams.de&gt;</a>
 
Quoted from the opensuse-ppc mailing list

</pre>
        <blockquote type="cite">
          <pre wrap="">I'm Wolfram Sang, maintainer of the I2C subsystem of the Linux Kernel. I
want to get rid of an ancient mechanism in the I2C core which was used in the
2.4 era. There are only two users left; drivers for old Macintosh computers I
don't have access to. So, I tried to emulate the behaviour on an ARM board and
wrote a replacement for the old mechanism which works fine here. Now, I wonder
if there are people willing to test these patches on the real thing? This would
be much appreciated!
</pre>
        </blockquote>
        <pre wrap="">
I have a bunch of older macs but none currently has linux and/or a current version of linux on them.  

What models do you need tested?  Can you point me to a quick easy to install distro?  I usually use openSUSE but I think Fedora has a ppc port now as well.

I only have 32bit macs.  I have:

iMac DV 400Mhz
PowerMac G4 Digital Audio 466Mhz
2 - PowerMac G3 Blue &amp; Whites (one with a G4 I THINK).
PowerMac 9600
PowerMac 9500
PowerMac 6500
PowerMac 6400
PowerMac G3 All In One Beige.
PowerBook G3 Wallstreet
</pre>
      </blockquote>
      <pre wrap="">
Thank you for the offer! I am still in the process to find out which
machines are "windtunnel" and which ones are "keywest". I thought this
would be easy once I found some Mac owners, but seems I was wrong...

I'll let you know if one of your machines could become useful.

Thanks again,

   Wolfram

</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://lists.ozlabs.org/listinfo/linuxppc-dev">https://lists.ozlabs.org/listinfo/linuxppc-dev</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------060105030906060907050908--
