Return-Path: <bsilverman@conceptxdesign.com>
Received: from smtprelay.hostedemail.com (smtprelay0061.hostedemail.com
	[216.40.44.61]) by ozlabs.org (Postfix) with ESMTP id ABEE6DDF4D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Apr 2008 01:38:53 +1000 (EST)
Received: from smtprelay.hostedemail.com (ff-bigip1 [10.5.19.254])
	by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 729E29AB14
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Apr 2008 15:20:35 +0000 (UTC)
Message-ID: <48076ABA.1030500@conceptxdesign.com>
Date: Thu, 17 Apr 2008 11:20:26 -0400
From: Brian Silverman <bsilverman@conceptxdesign.com>
MIME-Version: 1.0
To: Hugo Villeneuve <hugo.villeneuve@lyrtech.com>
Subject: Re: XLlTemac  soft lockup BUG
References: <16711066.post@talk.nabble.com>
	<42848A5C5A0D1E47B026E644DD49B08E025AA69F@mail>
In-Reply-To: <42848A5C5A0D1E47B026E644DD49B08E025AA69F@mail>
Content-Type: multipart/alternative;
	boundary="------------050706070003010309070207"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------050706070003010309070207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hugo,

We have a design with the BCM5482, and will be trying it out shortly.  
Any chance you could post a patch of your BCM5466 mods?

-bri

Hugo Villeneuve wrote:
> linuxppc-embedded-bounces+hugo.villeneuve=lyrtech.com@ozlabs.org wrote:
>   
>> Hi all,
>>
>> I am trying to switch my design from the PLB Temac to the local link
>> temac, and i have a problem when trying to run ifconfig in my init
>> script.  It gives me a BUG: soft lockup - CPU#0 stuck for 11s!
>> [ifconfig:208] Here is the rest of the dump, thanks for your help in
>> advance. [  233.114960] eth0: XLlTemac: Options: 0x3fa   
>>
>> [  233.118449] eth0: XLlTemac: allocating interrupt 8 for fifo mode.
>>
>> [  237.135029] eth0: XLlTemac: We renegotiated the speed to: 100
>>
>> [  237.150339] eth0: XLlTemac: speed set to 100Mb/s
>>
>> [  244.792140] BUG: soft lockup - CPU#0 stuck for 11s! [ifconfig:204]
>>     
>
> Hi,
> we had a similar error message, which was caused by us selecting the wrong PHY type in the kernel configuration menu (latest linux-2.6-xlnx-git tree). In fact, we had to modify the lltemac driver to support our PHY (BCM5466). Once we did that, the error message went away.
>
> Hugo V.
>
>
> Hugo Villeneuve
> Hardware developer | Concepteur matériel
> Lyrtech
> Phone/Tél. : (1) (418) 877-4644 #2395
> Toll-free/Sans frais - Canada & USA : (1) (888) 922-4644 #2395
> Fax/Téléc. : (1) (418) 877-7710
> www.lyrtech.com
> Infinite possibilities...TM
>
> THIS MESSAGE AND ALL ATTACHED DOCUMENTS ARE EXCLUSIVELY INTENDED
> TO THE INDICATED RECIPIENTS AND ITS CONTENTS MAY BE CONFIDENTIAL.
> IT IS STRICTLY FORBIDDEN TO ANYONE TO TAKE COGNIZANCE, USE, OR
> DIVULGE THE INFORMATION CONTAINED HEREIN. IF YOU MISTAKENLY
> RECEIVE THIS MESSAGE, IMMEDIATELY INFORM LYRTECH AND DESTROY THE
> MESSAGE AND ATTACHMENTS FORTHWITH.THANK YOU.
>
> LE PRESENT MESSAGE ET LES DOCUMENTS QUI Y SONT JOINTS S'ADRESSENT
> EXCLUSIVEMENT AU(X)DESTINATAIRE(S) INDIQUE(S) ET LEUR TENEUR PEUT
> ETRE CONFIDENTIELLE. IL EST STRICTEMENT INTERDIT A QUICONQUE D'EN
> PRENDRE CONNAISSANCE, DE LES UTILISER OU DE LES DIVULGUER. SI
> VOUS RECEVEZ LE PRESENT MESSAGE PAR ERREUR, VEUILLEZ EN AVISER
> LYRTECH IMMEDIATEMENT ET DETRUIRE LE MESSAGE SEANCE TENANTE,
> AINSI QUE LES DOCUMENTS QUI Y SONT JOINTS.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>   


-- 
Brian Silverman
Concept X, LLC


--------------050706070003010309070207
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hugo,<br>
<br>
We have a design with the BCM5482, and will be trying it out shortly.&nbsp;
Any chance you could post a patch of your BCM5466 mods?<br>
<br>
-bri<br>
<br>
Hugo Villeneuve wrote:
<blockquote cite="mid:42848A5C5A0D1E47B026E644DD49B08E025AA69F@mail"
 type="cite">
  <pre wrap=""><a class="moz-txt-link-abbreviated" href="mailto:linuxppc-embedded-bounces+hugo.villeneuve=lyrtech.com@ozlabs.org">linuxppc-embedded-bounces+hugo.villeneuve=lyrtech.com@ozlabs.org</a> wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi all,

I am trying to switch my design from the PLB Temac to the local link
temac, and i have a problem when trying to run ifconfig in my init
script.  It gives me a BUG: soft lockup - CPU#0 stuck for 11s!
[ifconfig:208] Here is the rest of the dump, thanks for your help in
advance. [  233.114960] eth0: XLlTemac: Options: 0x3fa   

[  233.118449] eth0: XLlTemac: allocating interrupt 8 for fifo mode.

[  237.135029] eth0: XLlTemac: We renegotiated the speed to: 100

[  237.150339] eth0: XLlTemac: speed set to 100Mb/s

[  244.792140] BUG: soft lockup - CPU#0 stuck for 11s! [ifconfig:204]
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Hi,
we had a similar error message, which was caused by us selecting the wrong PHY type in the kernel configuration menu (latest linux-2.6-xlnx-git tree). In fact, we had to modify the lltemac driver to support our PHY (BCM5466). Once we did that, the error message went away.

Hugo V.


Hugo Villeneuve
Hardware developer | Concepteur mat&eacute;riel
Lyrtech
Phone/T&eacute;l. : (1) (418) 877-4644 #2395
Toll-free/Sans frais - Canada &amp; USA : (1) (888) 922-4644 #2395
Fax/T&eacute;l&eacute;c. : (1) (418) 877-7710
<a class="moz-txt-link-abbreviated" href="http://www.lyrtech.com">www.lyrtech.com</a>
Infinite possibilities...TM

THIS MESSAGE AND ALL ATTACHED DOCUMENTS ARE EXCLUSIVELY INTENDED
TO THE INDICATED RECIPIENTS AND ITS CONTENTS MAY BE CONFIDENTIAL.
IT IS STRICTLY FORBIDDEN TO ANYONE TO TAKE COGNIZANCE, USE, OR
DIVULGE THE INFORMATION CONTAINED HEREIN. IF YOU MISTAKENLY
RECEIVE THIS MESSAGE, IMMEDIATELY INFORM LYRTECH AND DESTROY THE
MESSAGE AND ATTACHMENTS FORTHWITH.THANK YOU.

LE PRESENT MESSAGE ET LES DOCUMENTS QUI Y SONT JOINTS S'ADRESSENT
EXCLUSIVEMENT AU(X)DESTINATAIRE(S) INDIQUE(S) ET LEUR TENEUR PEUT
ETRE CONFIDENTIELLE. IL EST STRICTEMENT INTERDIT A QUICONQUE D'EN
PRENDRE CONNAISSANCE, DE LES UTILISER OU DE LES DIVULGUER. SI
VOUS RECEVEZ LE PRESENT MESSAGE PAR ERREUR, VEUILLEZ EN AVISER
LYRTECH IMMEDIATEMENT ET DETRUIRE LE MESSAGE SEANCE TENANTE,
AINSI QUE LES DOCUMENTS QUI Y SONT JOINTS.
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

  </pre>
</blockquote>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
Brian Silverman
Concept X, LLC
</pre>
</body>
</html>

--------------050706070003010309070207--
