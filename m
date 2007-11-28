Return-Path: <john.bonesio@xilinx.com>
Received: from mail180-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8DA22DDEDA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 07:16:36 +1100 (EST)
Received: from mail180-dub (localhost.localdomain [127.0.0.1])
	by mail180-dub-R.bigfish.com (Postfix) with ESMTP id 32DE9F388F5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 20:16:31 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail180-dub.bigfish.com (Postfix) with ESMTP id A61031178091
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 20:16:27 +0000 (UTC)
Received: from unknown-38-66.xilinx.com
	([149.199.38.66] helo=xsj-smtp1.xilinx.com
	ident=[U2FsdGVkX18RqQSITO0aKxT4egZ567sG8UdkO90txjU=])
	by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <john.bonesio@xilinx.com>) id 1IxTKd-0006xs-2P
	for linuxppc-embedded@ozlabs.org; Wed, 28 Nov 2007 12:16:27 -0800
From: John Bonesio <john.bonesio@xilinx.com>
To: "Simon George" <simong@xilinx.com>
Subject: Re: FW: CRS - #454833 is assigned to Amit Kasat for review by eliasd
Date: Wed, 28 Nov 2007 12:16:28 -0800
References: <689CB232690D8D4E97DA6C76DA098E6C0565CAD8@XCO-EXCHVS1.xlnx.xilinx.com>
	<20071128194846.0DCD61440075@mail24-blu.bigfish.com>
	<100AE4142881A8489779BF55E1832B3A06E98200@XIR-EXCHVS1.xlnx.xilinx.com>
In-Reply-To: <100AE4142881A8489779BF55E1832B3A06E98200@XIR-EXCHVS1.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <20071128201627.A61031178091@mail180-dub.bigfish.com>
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

Hi all,

Sorry for the spam. This was not intended for this list. Please ignore.

- John

On Wednesday 28 November 2007 12:11, Simon George wrote:
> Hi John
> 
> Id you mean to send that to the linuxppc alias?
> 
> Looks a rather internal email!
> 
> Regards
> 
> ------------------------------------------------------------------------
> ------------------------------------------------------------------------
> ---
>  
>      Simon George
>      Embedded Specialist (Northern Europe)
>  
> XILINX (UK) - Benchmark House, 203 Brooklands Road, WEYBRIDGE, Surrey
> KT13 0RH (UK)
> Office: +44 (0)870 7350 557         Mobile: +44 (0)7901 551704
> FAX: +44 (0)707 5023179
> ------------------------------------------------------------------------
> ------------------------------------------------------------------------
> ---
>  
> -----Original Message-----
> From: linuxppc-embedded-bounces+simon.george=xilinx.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+simon.george=xilinx.com@ozlabs.org] On
> Behalf Of John Bonesio
> Sent: 28 November 2007 19:49
> To: linuxppc-embedded@ozlabs.org
> Subject: Re: FW: CRS - #454833 is assigned to Amit Kasat for review by
> eliasd
> 
> Hi Rick,
> 
> I just checked more closely. The linux 2.6 mld uses the following
> directories:
> $XILINX_EDK/sw/ThirdParty/bsp/$MLD_version
> $XILINX_EDK/sw/XilinxProcessorIPLib/drivers
> <project directory>/bsp/$MLD_version
> 
> If 'edk_user_repository', is an actual directory name, then it is not
> used in the Linux MLD.
> 
> - John
> 
> 
> On Wednesday 28 November 2007 10:15, Rick Moleres wrote:
> > 
> > John,
> > 
> > So, the Linux MLD does use the edk_repository to search for drivers
> > etc...?
> > 
> > Thanks,
> > Rick
> > 
> > -----Original Message-----
> > From: John Bonesio [mailto:jbonesio@xilinx.com] 
> > Sent: Wednesday, November 28, 2007 10:54 AM
> > To: Rick Moleres
> > Cc: embedded_ip_sw
> > Subject: Re: FW: CRS - #454833 is assigned to Amit Kasat for review by
> > eliasd
> > 
> > Hi Rick,
> > 
> > It's possible we may need to change some (all?) of our mld's, but the
> > change should be small (on the order of 1-5 lines).
> > 
> > - John
> > 
> > On Wednesday 28 November 2007 08:20, Rick Moleres wrote:
> > > All,
> > > 
> > >  
> > > 
> > > Does this impact any of our MLDs?
> > > 
> > >  
> > > 
> > > Thanks,
> > > 
> > > Rick
> > > 
> > >  
> > > 
> > > ________________________________
> > > 
> > > From: Chang Sun 
> > > Sent: Tuesday, November 27, 2007 6:13 PM
> > > To: Amit Kasat; Randy Robinson; Rick Moleres
> > > Subject: RE: CRS - #454833 is assigned to Amit Kasat for review by
> > > eliasd
> > > 
> > >  
> > > 
> > > Hi Amit, 
> > > 
> > >  
> > > 
> > > I included Rick for this comment/suggestion, since Rick's team has
> > been
> > > doing most of the RTOS MLD integration work (Linux and VxWorks).
> Rick
> > > should be able to suggest the level of impact by this change. 
> > > 
> > > We also have some partners, e.g. Mentor Graphics supporting the MLD
> > > integration directly, so I hope this change has no major impact on
> > them,
> > > assuming we provide them well documented instructions. 
> > > 
> > >  
> > > 
> > > Thanks, 
> > > 
> > > Chang
> > > 
> > > ________________________________
> > > 
> > > From: Amit Kasat 
> > > Sent: Tuesday, November 27, 2007 2:30 PM
> > > To: Randy Robinson; Chang Sun
> > > Subject: FW: CRS - #454833 is assigned to Amit Kasat for review by
> > > eliasd
> > > 
> > >  
> > > 
> > > Hi Randy, Chang:
> > > 
> > >  
> > > 
> > > I would like to deprecate this mechanism of automatically reading
> > > edk_user_repository if this directory exists at the same level at
> EDK
> > > installation. I believe some of our Board and MLD partners use this
> > > mechanism. Going forward, we would like them to use the setting in
> XPS
> > > Gui's 
> > > 
> > >  
> > > 
> > > Edit -> Preferences -> Application Preferences -> Global Peripheral
> > > Repository
> > > 
> > >  
> > > 
> > > This is a much better, documented and GUI-supported way of
> specifiying
> > > peripheral repository path that's picked up automatically for all
> > > projects.
> > > 
> > >  
> > > 
> > > We will need to tell the partners to start using the new mechanism.
> > This
> > > mechanism gives them the flexibility to use any directory to install
> > > their XBD/MLDs and point to it using this setting. 
> > > 
> > >  
> > > 
> > > The edk_cr_review_team did not have any concerns about it. I just
> > wanted
> > > to make sure you guys are ok with it too.
> > > 
> > >  
> > > 
> > > Thanks,
> > > 
> > > Amit
> > > 
> > >  
> > > 
> > > > -----Original Message-----
> > > 
> > > > From: crs@xilinx.com [mailto:crs@xilinx.com]
> > > 
> > > > Sent: Tuesday, November 27, 2007 2:19 PM
> > > 
> > > > To: Amit Kasat
> > > 
> > > > Subject: CRS - #454833 is assigned to Amit Kasat for review by
> > eliasd
> > > 
> > > > 
> > > 
> > > > http://governator:9089/itg/html/kintanaHome.html
> > > 
> > > > 
> > > 
> > > > 
> > > 
> > > > CR #:                        454833
> > > 
> > > > CR Link:
> > > 
> > > >
> > >
> >
> http://governator:9089/itg//web/knta/crt/RequestDetail.jsp?REQUEST_ID=45
> > > 48
> > > 
> > > > 33
> > > 
> > > > Created By:                  Amit Kasat
> > > 
> > > > Creation Date:               20-NOV-07
> > > 
> > > > Description:                 Deprecate and then remove support of
> > > built in
> > > 
> > > > reposiotry - $XILINX_EDK/../edk_user_repository
> > > 
> > > > Status:                      New
> > > 
> > > > Application:                 EDK_General
> > > 
> > > > Assigned Group:              EDK
> > > 
> > > > Assigned To:                 Amit Kasat
> > > 
> > > > Priority:                    3
> > > 
> > > > Version Found:               EDK_K.9
> > > 
> > > > To Be Fixed Version:
> > > 
> > > > Apps Priority:               NA
> > > 
> > > > Details:                     Currently, If a directory named
> > > 
> > > > edk_user_repository is present at the same level as EDK
> > isntallation,
> > > then
> > > 
> > > > it is automaticaly added to the search path for pcores, drivers
> etc.
> > > 
> > > > However, in EDK 9.1, we added concept of Global Peripheral
> > Repository
> > > 
> > > > which allows users to add such a setting as a preference through
> the
> > > GUI
> > > 
> > > > and make it applicable to all thier projects.
> > > 
> > > > 
> > > 
> > > > This is a much cleaner mechanism of handling these search paths. I
> > > would
> > > 
> > > > like to deprecate usage of the edk_user_repository from tools in
> > EDK_K
> > > 
> > > > (issue a warning) and stop reading it in EDK_L.
> > > 
> > > > 
> > > 
> > > > These options are not used much and we woud like to cleanup to
> > reduce
> > > 
> > > > testing and corner case issues.
> > > 
> > > >
> > >
> >
> ------------------------------------------------------------------------
> > > --
> > > 
> > > > ---------------------------
> > > 
> > > > Notes:
> > > 
> > > > Elias Dabbagh(eliasd) November 27, 2007 02:18 PM:
> > > 
> > > > Assigned To   to Amit Kasat
> > > 
> > > > 
> > > 
> > > > Amit Kasat(akasat) November 20, 2007 03:58 PM:
> > > 
> > > > Public Data Directory /public/bugcases to
> > > 
> > > > http://governator:1111/public/bugcases/454000-454999/454833/
> > > 
> > > > 
> > > 
> > > > Amit Kasat(akasat) November 20, 2007 03:58 PM:
> > > 
> > > > Owner   to akasat
> > > 
> > > > 
> > > 
> > > > Amit Kasat(akasat) November 20, 2007 03:58 PM:
> > > 
> > > > Request Status Not Submitted to New
> > > 
> > > > 
> > > 
> > > > 
> > > 
> > > > 
> > > 
> > > >
> > >
> >
> ========================================================================
> > > ==
> > > 
> > > > ==
> > > 
> > > > 
> > > 
> > >  
> > > 
> > > 
> > 
> > -- 
> > +-------------------------------+
> > |  This space for rent 
> > +-------------------------------+
> > 
> 
> -- 
> +-------------------------------+
> |  This space for rent 
> +-------------------------------+
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
+-------------------------------+
|  This space for rent 
+-------------------------------+
