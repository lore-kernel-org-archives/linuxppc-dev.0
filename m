Return-Path: <jean-marie.teuler@lcp.u-psud.fr>
Received: from smtp1.u-psud.fr (smtp1.u-psud.fr [129.175.33.41])
	by ozlabs.org (Postfix) with ESMTP id 5BFB467B1D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 May 2006 20:34:42 +1000 (EST)
Subject: Re: Impossible to open the root console with 2.6.15
From: Jean-Marie Teuler <jean-marie.teuler@lcp.u-psud.fr>
To: jfaslist <jfaslist@yahoo.fr>
In-Reply-To: <4458E28E.8080705@yahoo.fr>
References: <1146663369.2448.25.camel@khnoum.lcp.u-psud.fr>
	<4458E28E.8080705@yahoo.fr>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 04 May 2006 12:35:58 +0200
Message-Id: <1146738958.6866.4.camel@khnoum.lcp.u-psud.fr>
Mime-Version: 1.0
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

Dear Jean-François,

> But in fact, wwe had a similar case recently (no console outputs, but 
> linux running OK) and I am told that the problem was with  the "virtual 
> terminal"  option that needed to be disabled:
> 
> Device Drivers
> -> Character devices
>  -> [ ] Virtual Terminal
> 	serial drivers->
> 		<*> CPM SCC/SMC serial port support
>  		 <*> Support for console CMP SCC/SMC serial port......

Thanks. This solved the problem. Just by disabling the virtual
terminals!

Jean-Marie
