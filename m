Return-Path: <anton@ozlabs.org>
Message-Id: <20070321013810.404636000@samba.org>
Date: Tue, 20 Mar 2007 20:38:10 -0500
From: anton@samba.org
To: linuxppc-dev@ozlabs.org
Subject: [patch 00/10] Oops path and debugger hooks rework
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following series cleans up our oops printout code and adds some missing
functionality. It also changes xmon over to use the notify_die hooks and
removes the awful debugger* hooks.
