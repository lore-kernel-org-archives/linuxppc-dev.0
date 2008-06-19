Return-Path: <VONBOEHN@de.ibm.com>
In-Reply-To: <200806191353.17323.arnd@arndb.de>
References: <200806191753.51495.markn@au1.ibm.com>
	<200806191353.17323.arnd@arndb.de>
Subject: Re: [RFC 0/3] powerpc: memory copy routines tweaked for Cell
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <OF44809729.FB9D2C51-ONC125746D.00429A93-C125746D.0042FB12@de.ibm.com>
From: Gunnar von Boehn <VONBOEHN@de.ibm.com>
Date: Thu, 19 Jun 2008 14:11:22 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Michael Ellerman <ellerman@au1.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Arnd,

I have no results for P5/P6, but I did some tests on JS21 aka PPC-970.
On PPC-970 the CELL memcpy is faster than the current Linux routine.
This becomes really visible when you really copy memory-to-memory and are
not only working in the 2ndlevelcache.


Kind regards

Gunnar von Boehn




                                                                           
             Arnd Bergmann                                                 
             <arnd@arndb.de>                                               
                                                                        To 
             19/06/2008 13:53          linuxppc-dev@ozlabs.org             
                                                                        cc 
                                       Mark Nelson <markn@au1.ibm.com>,    
                                       cbe-oss-dev@ozlabs.org, Gunnar von  
                                       Boehn/Germany/Contr/IBM@IBMDE,      
                                       Michael Ellerman                    
                                       <ellerman@au1.ibm.com>              
                                                                   Subject 
                                       Re: [RFC 0/3] powerpc: memory copy  
                                       routines tweaked for Cell           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           




On Thursday 19 June 2008, Mark Nelson wrote:
> The plan is to use Michael Ellerman's code patching work so that at
runtime
> if we're running on a Cell machine the new routines are called but
otherwise
> the existing memory copy routines are used.

Have you tried running this code on other platforms to see if it
actually performs worse on any of them? I would guess that the
older code also doesn't work too well on Power 5 and Power 6, so the
cell optimized version could give us a significant advantage as well,
albeit less than another CPU specific version.

             Arnd <><
