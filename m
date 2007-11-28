Return-Path: <john.bonesio@xilinx.com>
Received: from outbound5-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4E23ADDE22
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Nov 2007 06:52:19 +1100 (EST)
Received: from outbound5-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound5-blu-R.bigfish.com (Postfix) with ESMTP id E98BEA119F2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 19:48:48 +0000 (UTC)
Received: from mail24-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound5-blu.bigfish.com (Postfix) with ESMTP id DAE6F428059
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 19:48:48 +0000 (UTC)
Received: from mail24-blu (localhost.localdomain [127.0.0.1])
	by mail24-blu-R.bigfish.com (Postfix) with ESMTP id 075D710582C9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 19:48:47 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail24-blu.bigfish.com (Postfix) with ESMTP id 0DCD61440075
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Nov 2007 19:48:46 +0000 (UTC)
Received: from unknown-38-66.xilinx.com
	([149.199.38.66] helo=xsj-smtp1.xilinx.com
	ident=[U2FsdGVkX19msZlqv3vRH5zVWFIyXhYqJMr2l+cooDo=])
	by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <john.bonesio@xilinx.com>) id 1IxStp-00042w-Os
	for linuxppc-embedded@ozlabs.org; Wed, 28 Nov 2007 11:48:45 -0800
From: John Bonesio <john.bonesio@xilinx.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: FW: CRS - #454833 is assigned to Amit Kasat for review by eliasd
Date: Wed, 28 Nov 2007 11:48:46 -0800
References: <689CB232690D8D4E97DA6C76DA098E6C0565CAD8@XCO-EXCHVS1.xlnx.xilinx.com>
	<200711280954.15686.jbonesio@xilinx.com>
	<689CB232690D8D4E97DA6C76DA098E6C0565CBFB@XCO-EXCHVS1.xlnx.xilinx.com>
In-Reply-To: <689CB232690D8D4E97DA6C76DA098E6C0565CBFB@XCO-EXCHVS1.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <20071128194846.0DCD61440075@mail24-blu.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Rick,

I just checked more closely. The linux 2.6 mld uses the following directories:
$XILINX_EDK/sw/ThirdParty/bsp/$MLD_version
$XILINX_EDK/sw/XilinxProcessorIPLib/drivers
<project directory>/bsp/$MLD_version

If 'edk_user_repository', is an actual directory name, then it is not used in the Linux MLD.

- John


On Wednesday 28 November 2007 10:15, Rick Moleres wrote:
> 
> John,
> 
> So, the Linux MLD does use the edk_repository to search for drivers
> etc...?
> 
> Thanks,
> Rick
> 
> -----Original Message-----
> From: John Bonesio [mailto:jbonesio@xilinx.com] 
> Sent: Wednesday, November 28, 2007 10:54 AM
> To: Rick Moleres
> Cc: embedded_ip_sw
> Subject: Re: FW: CRS - #454833 is assigned to Amit Kasat for review by
> eliasd
> 
> Hi Rick,
> 
> It's possible we may need to change some (all?) of our mld's, but the
> change should be small (on the order of 1-5 lines).
> 
> - John
> 
> On Wednesday 28 November 2007 08:20, Rick Moleres wrote:
> > All,
> > 
> >  
> > 
> > Does this impact any of our MLDs?
> > 
> >  
> > 
> > Thanks,
> > 
> > Rick
> > 
> >  
> > 
> > ________________________________
> > 
> > From: Chang Sun 
> > Sent: Tuesday, November 27, 2007 6:13 PM
> > To: Amit Kasat; Randy Robinson; Rick Moleres
> > Subject: RE: CRS - #454833 is assigned to Amit Kasat for review by
> > eliasd
> > 
> >  
> > 
> > Hi Amit, 
> > 
> >  
> > 
> > I included Rick for this comment/suggestion, since Rick's team has
> been
> > doing most of the RTOS MLD integration work (Linux and VxWorks). Rick
> > should be able to suggest the level of impact by this change. 
> > 
> > We also have some partners, e.g. Mentor Graphics supporting the MLD
> > integration directly, so I hope this change has no major impact on
> them,
> > assuming we provide them well documented instructions. 
> > 
> >  
> > 
> > Thanks, 
> > 
> > Chang
> > 
> > ________________________________
> > 
> > From: Amit Kasat 
> > Sent: Tuesday, November 27, 2007 2:30 PM
> > To: Randy Robinson; Chang Sun
> > Subject: FW: CRS - #454833 is assigned to Amit Kasat for review by
> > eliasd
> > 
> >  
> > 
> > Hi Randy, Chang:
> > 
> >  
> > 
> > I would like to deprecate this mechanism of automatically reading
> > edk_user_repository if this directory exists at the same level at EDK
> > installation. I believe some of our Board and MLD partners use this
> > mechanism. Going forward, we would like them to use the setting in XPS
> > Gui's 
> > 
> >  
> > 
> > Edit -> Preferences -> Application Preferences -> Global Peripheral
> > Repository
> > 
> >  
> > 
> > This is a much better, documented and GUI-supported way of specifiying
> > peripheral repository path that's picked up automatically for all
> > projects.
> > 
> >  
> > 
> > We will need to tell the partners to start using the new mechanism.
> This
> > mechanism gives them the flexibility to use any directory to install
> > their XBD/MLDs and point to it using this setting. 
> > 
> >  
> > 
> > The edk_cr_review_team did not have any concerns about it. I just
> wanted
> > to make sure you guys are ok with it too.
> > 
> >  
> > 
> > Thanks,
> > 
> > Amit
> > 
> >  
> > 
> > > -----Original Message-----
> > 
> > > From: crs@xilinx.com [mailto:crs@xilinx.com]
> > 
> > > Sent: Tuesday, November 27, 2007 2:19 PM
> > 
> > > To: Amit Kasat
> > 
> > > Subject: CRS - #454833 is assigned to Amit Kasat for review by
> eliasd
> > 
> > > 
> > 
> > > http://governator:9089/itg/html/kintanaHome.html
> > 
> > > 
> > 
> > > 
> > 
> > > CR #:                        454833
> > 
> > > CR Link:
> > 
> > >
> >
> http://governator:9089/itg//web/knta/crt/RequestDetail.jsp?REQUEST_ID=45
> > 48
> > 
> > > 33
> > 
> > > Created By:                  Amit Kasat
> > 
> > > Creation Date:               20-NOV-07
> > 
> > > Description:                 Deprecate and then remove support of
> > built in
> > 
> > > reposiotry - $XILINX_EDK/../edk_user_repository
> > 
> > > Status:                      New
> > 
> > > Application:                 EDK_General
> > 
> > > Assigned Group:              EDK
> > 
> > > Assigned To:                 Amit Kasat
> > 
> > > Priority:                    3
> > 
> > > Version Found:               EDK_K.9
> > 
> > > To Be Fixed Version:
> > 
> > > Apps Priority:               NA
> > 
> > > Details:                     Currently, If a directory named
> > 
> > > edk_user_repository is present at the same level as EDK
> isntallation,
> > then
> > 
> > > it is automaticaly added to the search path for pcores, drivers etc.
> > 
> > > However, in EDK 9.1, we added concept of Global Peripheral
> Repository
> > 
> > > which allows users to add such a setting as a preference through the
> > GUI
> > 
> > > and make it applicable to all thier projects.
> > 
> > > 
> > 
> > > This is a much cleaner mechanism of handling these search paths. I
> > would
> > 
> > > like to deprecate usage of the edk_user_repository from tools in
> EDK_K
> > 
> > > (issue a warning) and stop reading it in EDK_L.
> > 
> > > 
> > 
> > > These options are not used much and we woud like to cleanup to
> reduce
> > 
> > > testing and corner case issues.
> > 
> > >
> >
> ------------------------------------------------------------------------
> > --
> > 
> > > ---------------------------
> > 
> > > Notes:
> > 
> > > Elias Dabbagh(eliasd) November 27, 2007 02:18 PM:
> > 
> > > Assigned To   to Amit Kasat
> > 
> > > 
> > 
> > > Amit Kasat(akasat) November 20, 2007 03:58 PM:
> > 
> > > Public Data Directory /public/bugcases to
> > 
> > > http://governator:1111/public/bugcases/454000-454999/454833/
> > 
> > > 
> > 
> > > Amit Kasat(akasat) November 20, 2007 03:58 PM:
> > 
> > > Owner   to akasat
> > 
> > > 
> > 
> > > Amit Kasat(akasat) November 20, 2007 03:58 PM:
> > 
> > > Request Status Not Submitted to New
> > 
> > > 
> > 
> > > 
> > 
> > > 
> > 
> > >
> >
> ========================================================================
> > ==
> > 
> > > ==
> > 
> > > 
> > 
> >  
> > 
> > 
> 
> -- 
> +-------------------------------+
> |  This space for rent 
> +-------------------------------+
> 

-- 
+-------------------------------+
|  This space for rent 
+-------------------------------+
