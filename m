Return-Path: <jfaslist@yahoo.fr>
Received: from smtp008.mail.ukl.yahoo.com (smtp008.mail.ukl.yahoo.com
	[217.12.11.62]) by ozlabs.org (Postfix) with SMTP id 0D43667AC6
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 03:04:30 +1000 (EST)
Message-ID: <4458E28E.8080705@yahoo.fr>
Date: Wed, 03 May 2006 19:04:14 +0200
From: jfaslist <jfaslist@yahoo.fr>
MIME-Version: 1.0
To: Jean-Marie Teuler <jean-marie.teuler@lcp.u-psud.fr>
Subject: Re: Impossible to open the root console with 2.6.15
References: <1146663369.2448.25.camel@khnoum.lcp.u-psud.fr>
In-Reply-To: <1146663369.2448.25.camel@khnoum.lcp.u-psud.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Jean-Marie Teuler wrote:

>Hi there,
>
>I am trying to use ELDK 4.0 on my TQM860L board.
>
>I have compiled the included 2.6.15 kernel with reasonable options, but
>when I try to boot it, I do not get the prompt after the message
>"Uncompressing Kernel Image ... OK"
>  
>
It could be a FAQ:
http://www.denx.de/wiki/DULG/LinuxHangsAfterUncompressingKernel

But in fact, wwe had a similar case recently (no console outputs, but 
linux running OK) and I am told that the problem was with  the "virtual 
terminal"  option that needed to be disabled:

Device Drivers
-> Character devices
 -> [ ] Virtual Terminal
	serial drivers->
		<*> CPM SCC/SMC serial port support
 		 <*> Support for console CMP SCC/SMC serial port......

 --

Best regards,
_______________________________________
jean-francois simon - themis computer
5, rue irene joliot curie
38330 eybens - france
+33 (0)870 448 638
+33 (0)4 76 14 77 85


	

	
		
___________________________________________________________________________ 
Faites de Yahoo! votre page d'accueil sur le web pour retrouver directement vos services préférés : vérifiez vos nouveaux mails, lancez vos recherches et suivez l'actualité en temps réel. 
Rendez-vous sur http://fr.yahoo.com/set
