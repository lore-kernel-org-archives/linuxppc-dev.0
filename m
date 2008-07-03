Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18541.25199.153252.824136@cargo.ozlabs.ibm.com>
Date: Fri, 4 Jul 2008 09:36:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: avorontsov@ru.mvista.com
Subject: Re: New fsl device bindings file
In-Reply-To: <20080703185312.GA6043@polina.dev.rtsoft.ru>
References: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
	<20080703185312.GA6043@polina.dev.rtsoft.ru>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov writes:

> Just curious... why we're maintaining documentation in the .txt file?
> We could just create Documentation/powerpc/fsl-device-tree-bindings.dts
> file, that will be:
> 
> 1. True device tree source file;
> 2. With a lots of comments for documentation purposes;
> 3. Could be compiled (via imaginable dts-doxygen) into .txt or nice .pdf
>    file and printed :-), exactly as we do with kerneldoc.

I suspect that will be harder to follow for people that are unfamiliar
with device trees...

Paul.
