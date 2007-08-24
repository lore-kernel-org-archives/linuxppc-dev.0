Return-Path: <jalmeida@sysgo.fr>
Message-ID: <46CED851.70002@sysgo.fr>
Date: Fri, 24 Aug 2007 15:08:33 +0200
From: Jose Almeida <jalmeida@sysgo.fr>
MIME-Version: 1.0
To: Joyeau Sylvain <Sylvain.Joyeau@thomson.net>
Subject: Re: little endian page mapping on PQ3
References: <B00307ADBC68954AA8D6FB3AC8FD66F30141DE36@rennsmail05.eu.thmulti.com>
In-Reply-To: <B00307ADBC68954AA8D6FB3AC8FD66F30141DE36@rennsmail05.eu.thmulti.com>
Content-Type: text/html; charset=ISO-8859-1
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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Sylvain,<br>
<br>
Thanks for the information... I will try this.<br>
What I really need to do is to map these pages at user level (these
pages will be contiguous pages, because they are used for DMA purpose).<br>
<br>
I want to do using an mmap() entry point in a driver, in order to map
this to the user. Of course in that case ioremap() does not work.<br>
<br>
Any Clue ?<br>
<br>
Thanks - Jose<br>
<br>
Joyeau Sylvain wrote:
<blockquote
 cite="midB00307ADBC68954AA8D6FB3AC8FD66F30141DE36@rennsmail05.eu.thmulti.com"
 type="cite">
  <pre wrap="">Jose,

You are right, PQ3 supports endianess choice on a per page basis. 
Without any hook in Linux, you can remap physical address range (but RAM), by calling __ioremap() with the "_PAGE_ENDIAN" bit set in the flags.

--
sj

  </pre>
  <blockquote type="cite">
    <pre wrap="">-----Original Message-----
From: 
<a class="moz-txt-link-abbreviated" href="mailto:linuxppc-embedded-bounces+sylvain.joyeau=thomson.net@ozlabs.or">linuxppc-embedded-bounces+sylvain.joyeau=thomson.net@ozlabs.or</a>
g 
[<a class="moz-txt-link-freetext" href="mailto:linuxppc-embedded-bounces+sylvain.joyeau=thomson.net@o">mailto:linuxppc-embedded-bounces+sylvain.joyeau=thomson.net@o</a>
zlabs.org] On Behalf Of Jose Almeida
Sent: vendredi 24 ao&ucirc;t 2007 09:59
To: <a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
Subject: little endian page mapping on PQ3

Hi all,

Looking at PQ3 documentation, it looks like there is a way to select
on a page basis if we would like to map one particular page in BIG or
LITTLE endian.
This is a very nice feature when you need to exchange some data
between a PC and a PQ3 target.

I am wondering if someone have already tryed this PQ3 feature ?
I guess this would require some kind of hook in the kernel ...

Any clue ?

Thanks -  Jose

_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

    </pre>
  </blockquote>
  <pre wrap=""><!---->_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>


  </pre>
</blockquote>
<br>
<br>
<pre class="moz-signature" cols="72">-- 


Meet us at our next event:

MAKS - August 21-26, 2007
Moscow, Russia
<a class="moz-txt-link-freetext" href="http://www.aviasalon.com">http://www.aviasalon.com</a>

TechTalk Hamburg - September 26, 2007
Hamburg, Germany
<a class="moz-txt-link-freetext" href="http://www.sysgo.com/news-events/events">http://www.sysgo.com/news-events/events</a>

MAE - October 20, 2007
Gaydon, United Kingdom
<a class="moz-txt-link-freetext" href="http://www.mae-show.com/">http://www.mae-show.com/</a>

</pre>
</body>
</html>
